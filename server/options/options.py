from nltk.corpus import wordnet as wn
from pywsd.similarity import max_similarity
from pywsd.lesk import adapted_lesk
from pywsd.lesk import simple_lesk
from pywsd.lesk import cosine_lesk


def _get_distractors_wordnet(syn, word):
    distractors = []
    word = word.lower()
    orig_word = word
    if len(word.split()) > 0:
        word = word.replace(" ", "_")
    hypernym = syn.hypernyms()
    print(hypernym)
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
    word = word.lower()

    if len(word.split()) > 0:
        word = word.replace(" ", "_")

    synsets = wn.synsets(word, 'n')
    if synsets:
        wup = max_similarity(sent, word, 'wup', pos='n')
        adapted_lesk_output = adapted_lesk(sent, word, pos='n')
        lowest_index = min(synsets.index(
            wup), synsets.index(adapted_lesk_output))
        return synsets[lowest_index]
    else:
        return None


def getOptions(sent, word):
    wordsense = _get_wordsense(sent, word)
    if wordsense:
        distractors = _get_distractors_wordnet(wordsense, word)
        return distractors
    return []
