import spacy
import re
from spacy import Language
from spacy_wordnet.wordnet_annotator import WordnetAnnotator
import random
import string

from nltk.stem import PorterStemmer
ps = PorterStemmer()


nlp = spacy.load("en_core_web_sm")
s2v = nlp.add_pipe("sense2vec")
s2v.from_disk("s2v_old")
nlp.add_pipe("spacy_wordnet", after='tagger')
spacy_wordnet_annotator = WordnetAnnotator(nlp.lang)

PRIOR_LIST = ['NUM', 'ADJ']


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
        avoidWord = str(ps.stem(token.lemma_)).strip()
        reWord = ''
        reKey = ''
        for word in sense[0][0].split():
            stemmed = ps.stem(word).strip()
            if avoidWord == stemmed:
                reWord = ''
                reKey = ''
                break
            else:
                reKey = reKey + ' ' + stemmed
                reWord = reWord + ' ' + word
        reWord = reWord.strip().rstrip('-')
        if reWord and reWord != avoidWord:
            filteredSense[reKey.strip()] = reWord
    options = list(filteredSense.values())

    return options


def _getNumOptions(token):
    options = []
    for i in range(10):
        rep = re.sub('[^\D0]', lambda x: str(random.randint(1, 9)), token.text)
        options.append(rep)
    return options


def _mispelledOptions(token):
    options = []
    for i in range(6):
        ind = random.randint(0, len(token.text)-1)
        rep = token.text[:ind] + \
            random.choice(string.ascii_lowercase) + token.text[ind+1:]
        if(token.text is not rep):
            options.append(rep)
    return options


def case_insensitive_unique_list(data, answer):
    seen, result = set(), []
    seen.add(answer.lower())
    for item in data:
        if item.lower() not in seen:
            seen.add(item.lower())
            result.append(item)
    return result


def formattedOptions(answer, correct, options, question, context):
    ans = re.sub(correct, '________', answer, flags=re.IGNORECASE)
    opts = case_insensitive_unique_list(options, correct)
    return {
        'answer': ans,
        'correct': correct,
        'options': opts,
        'question': question,
        'context': context
    }


def getOptions(item):
    context = item['context']
    answer = item['answer'].strip()  # [6:].strip()
    question = item['question']

    doc = nlp(context)

    options = []
    for ent in doc.ents:
        if re.search(ent.text, answer, re.IGNORECASE):
            if ent._.in_s2v:
                options = _createOptions(ent)
                if(len(options) > 0):
                    return formattedOptions(answer, ent.text, options, question, context)

    if len(options) == 0:
        tokenList = []
        for token in doc:
            if not token.is_punct and not token.is_stop and re.search(token.text, answer, re.IGNORECASE):
                tokenList.append(token)

        random.shuffle(tokenList)
        tokenList.sort(key=lambda tok: PRIOR_LIST.index(
            tok.pos_) if tok.pos_ in PRIOR_LIST else 1000)
        # if num
        if (len(tokenList) > 0 and tokenList[0].pos_ == PRIOR_LIST[0]):
            token = tokenList[0]
            options = _getNumOptions(token)
            if(len(options) > 0):
                return formattedOptions(answer, token.text, options, question, context)

        if len(options) == 0:
            for token in tokenList:  # random check options significantly
                if token._.in_s2v:
                    options = _createOptions(token)
                    if(len(options) > 0):
                        return formattedOptions(answer, token.text, options, question, context)

        if len(options) == 0:
            for token in tokenList:
                options = _getAntonyms(token)
                if(len(options) > 0):
                    return formattedOptions(answer, token.text, options, question, context)

        if len(options) == 0:
            for token in tokenList:
                options = _forcedOptions(token)
                if(len(options) > 0):
                    return formattedOptions(answer, token.text, options, question, context)

        if len(options) == 0:
            for token in tokenList:
                options = _mispelledOptions(token)
                if(len(options) > 0):
                    return formattedOptions(answer, token.text, options, question, context)

    return formattedOptions(answer, answer, ['True', 'False'], question, context)
