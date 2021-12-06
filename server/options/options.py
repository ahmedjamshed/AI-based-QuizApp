from nltk.corpus import wordnet as wn
from pywsd.similarity import max_similarity
from pywsd.lesk import adapted_lesk
from pywsd.lesk import simple_lesk
from pywsd.lesk import cosine_lesk
import spacy
import re

nlp = spacy.load("en_core_web_sm")
# s2v = nlp.add_pipe("sense2vec")
# s2v.from_disk("s2v_old")


def _get_distractors_wordnet(syn, word):
    distractors = []
    word = word.lower()
    orig_word = word
    if len(word.split()) > 0:
        word = word.replace(" ", "_")
    if syn.pos() in ['a', 's']:
        for lemma in syn.lemmas():
            if lemma.antonyms():
                for ant in lemma.antonyms():
                    distractors.append(ant.name())
    hypernym = syn.hypernyms()
    if len(hypernym) == 0:
        return distractors
    for hyp in hypernym:
        for hyper in hyp.hypernyms():
            for item in hyper.hyponyms():
                for term in item.lemmas():
                    name = term.name()
                    print(name)
                    #print ("name ",name, " word",orig_word)
                    if name == orig_word:
                        continue
                    name = name.replace("_", " ")
                    name = " ".join(w.capitalize() for w in name.split())
                    if name is not None and name not in distractors:
                        distractors.append(name)
    return distractors


def _get_wordsense(sent, word):
    rootWord = word.lower()
    if len(rootWord.split()) > 0:
        rootWord = rootWord.replace(" ", "_")
    # rootWord = wn.morphy(word)
    synsets = wn.synsets(rootWord)
    if synsets:
        wup = max_similarity(sent, rootWord, 'wup')
        adapted_lesk_output = adapted_lesk(sent, rootWord)
        lowest_index = min(synsets.index(
            wup), synsets.index(adapted_lesk_output))
        return synsets[lowest_index]
    else:
        return None


def _getAntonyms(word, context):
    syn = _get_wordsense(context, word)
    antonyms = []
    if syn:
        for lemma in syn.lemmas():
            if lemma.antonyms():
                for ant in lemma.antonyms():
                    antonyms.append(ant.name())
    return antonyms


def getOptions(question):
    print('\n\n')
    context = question['context']
    answer = question['answer'][6:].strip()
    print(context, answer)
    doc = nlp(context)
    for token in doc:
        if token.is_alpha and not token.is_stop and re.search(token.text, answer, re.IGNORECASE):
            antonyms = _getAntonyms(token.lemma_, context)
            # if len(antonyms) == 0 and token._.in_s2v:
            #     print(token.text, token.lemma_, token.pos_, token.tag_, token.dep_,
            #           token.shape_, token.is_alpha, token.is_stop, token._.s2v_most_similar(3))
            # else:
            #     print(token.text, antonyms)

    # wordsense = _get_wordsense(context, answer)
    # if wordsense:
    #     distractors = _get_distractors_wordnet(wordsense, answer)
    #     return distractors
    return []
