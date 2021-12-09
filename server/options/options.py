import spacy
import re
from spacy import Language
from spacy_wordnet.wordnet_annotator import WordnetAnnotator
import random
import re
from nltk.stem import PorterStemmer
ps = PorterStemmer()


nlp = spacy.load("en_core_web_sm")
s2v = nlp.add_pipe("sense2vec")
s2v.from_disk("s2v_old")
nlp.add_pipe("spacy_wordnet", after='tagger')
spacy_wordnet_annotator = WordnetAnnotator(nlp.lang)


@Language.component("wordnet")
def spacy_wordnet_wrapper(doc):
    return spacy_wordnet_annotator(doc)


def _getAntonyms(token):
    antonyms = []
    for sysnet in token._.wordnet.synsets():
        for lemma in sysnet.lemmas():
            if lemma.antonyms():
                for ant in lemma.antonyms():
                    antonyms.append(ant.name())
                    if len(antonyms) > 10:
                        return antonyms

    return antonyms


def _forcedOptions(token):
    options = []
    for sysnet in token._.wordnet.synsets():
        for hyper in sysnet.hypernyms():
            for item in hyper.hyponyms():
                for term in item.lemmas():
                    name = term.name()
                    if name == token.text or name == token.lemma_:
                        continue
                    name = name.replace("_", " ")
                    if name is not None and name not in options:
                        options.append(name)
                        if len(options) > 10:
                            return options

    return options


def _createOptions(token):

    senseWords = token._.s2v_most_similar(20)
    # print(token.text, token.lemma_, token.pos_, token.tag_, token.dep_,
    #                     token.shape_, token.is_alpha, token.is_stop, senseWords)
    filteredSense = dict()
    for sense in senseWords:
        avoidWord = ps.stem(token.lemma_)
        reWord = ''
        reKey = ''
        for word in sense[0][0].split():
            stemmed = ps.stem(word)
            if avoidWord == stemmed:
                reWord = ''
                reKey = ''
                break
            else:
                reKey = reKey + ' ' + stemmed
                reWord = reWord + ' ' + word

        if reWord:
            filteredSense[reKey.strip()] = reWord.strip().rstrip('-')
    options = list(filteredSense.values())

    return options


def getOptions(item):
    context = item['context']
    answer = item['answer'][6:].strip()
    question = item['question']

    doc = nlp(context)

    options = []
    for ent in doc.ents:
        if re.search(ent.text, answer, re.IGNORECASE):
            if ent._.in_s2v:
                options = _createOptions(ent)
                if(len(options) > 0):
                    return {
                        'answer': answer.replace(ent.text, '________'),
                        'correct': ent.text,
                        'options': options,
                        'question': question,
                        'context': context
                    }

    if len(options) == 0:
        tokenList = []
        for token in doc:
            if token.is_alpha and not token.is_stop and re.search(token.text, answer, re.IGNORECASE):
                tokenList.append(token)
        random.shuffle(tokenList)

        for token in tokenList:  # random check options significantly
            if token._.in_s2v:
                options = _createOptions(token)
                if(len(options) > 0):
                    return {
                        'answer': answer.replace(token.text, '________'),
                        'correct': token.text,
                        'options': options,
                        'question': question,
                        'context': context
                    }

        if len(options) == 0:
            for token in tokenList:
                options = _getAntonyms(token)
                if(len(options) > 0):
                    return {
                        'answer': answer.replace(token.text, '________'),
                        'correct': token.text,
                        'options': options,
                        'question': question,
                        'context': context
                    }

        if len(options) == 0:
            for token in tokenList:
                options = _forcedOptions(token)
                if(len(options) > 0):
                    return {
                        'answer': answer.replace(token.text, '________'),
                        'correct': token.text,
                        'options': options,
                        'question': question,
                        'context': context
                    }

    return {
        'answer': answer,
        'correct': token.text,
        'options': ['True', 'False'],
        'question': question,
        'context': context
    }
