import nltk
from nltk.stem import WordNetLemmatizer
from fastapi import FastAPI
from fastapi.responses import JSONResponse
from google.cloud import vision
import proto
from pydantic import BaseModel
import base64
from pydantic.types import Json
import question_generation
import numpy as np
import pandas as pd
from sklearn import linear_model
import joblib
import re
import time
from dotenv import dotenv_values
from sklearn.feature_extraction.text import CountVectorizer
from fastapi.middleware.cors import CORSMiddleware

import nest_asyncio
from pyngrok import ngrok
import uvicorn
from bs4 import *
import requests

from parser.wikiPage import wikiPage
from parser.wikiPage import wikiPages

from options.options import getOptions
# import requests
# import tarfile

# url = "https://github.com/explosion/sense2vec/releases/download/v1.0.0/s2v_reddit_2015_md.tar.gz"
# response = requests.get(url, stream=True)
# file = tarfile.open(fileobj=response.raw, mode="r|gz")
# file.extractall(path=".")


config = dotenv_values(".env")

# nltk.download('wordnet')
# nltk.download('punkt')
# nltk.download('averaged_perceptron_tagger')

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=['*'],
    allow_credentials=True,
    allow_methods=['*'],
    allow_headers=['*'],
)

qgPipe = question_generation.pipeline(
    "question-generation", model="valhalla/t5-small-qg-prepend", qg_format="prepend")

###################################################


def pre_processing(text):
    return ' '
###################################################


###################################################

def data_extractor(url):
    return ' '
###################################################


class Body(BaseModel):
    data: str


def getMachineLabel(ids):
    headers = {
        'Accept': 'application/json',
    }
    print(config['GAPI_KEY'])
    params = (
        ('ids', ids),
        ('key', config['GAPI_KEY']),
    )
    try:
        response = requests.get(
            'https://kgsearch.googleapis.com/v1/entities:search', headers=headers, params=params)
        topics = map(lambda item: item['result']['detailedDescription']
                     ['url'].split("/")[-1], response.json()['itemListElement'])
        # print(*topics)
        return list(topics)
    except requests.exceptions.RequestException as err:
        print(err)
        raise err


def detect_labels_uri(source: str):
    """Detects labels in the file located in Google Cloud Storage or on the Web."""
    client = vision.ImageAnnotatorClient()
    request = {
        'image': {
            'source': {'image_uri': source},
        },
    } if source.startswith('http') else {
        'image': {
            "content": base64.decodebytes(source.encode('utf-8'))
        },
    }
    response = client.annotate_image(request)

    if response.error.message:
        raise Exception(
            '{}\nFor more info on error messages, check: '
            'https://cloud.google.com/apis/design/errors'.format(
                response.error.message))
    return [proto.Message.to_dict(tag) for tag in response.label_annotations]


@app.post('/generateQuestions')
async def generateQuestions(req: Body):
    # url = getMachineLabel([id])
    # title = url.split("/")[-1]
    # topics = wikiPage(title)
    # return topics
    # print(data['extract'])
    # paras = data['paragraphs']
    # text = ' '.join(paras[:5])
    # summary = ' '.join(re.split(r'(?<=[.?!])\s+', text, 15)[:-1])
    # print(summary)

    # main
    # start = time.time()
    QUESTIONS = qgPipe(req.data)
    # end = time.time()
    # print((end - start))
    questions = []
    for ques in QUESTIONS:
        # TODO: Remove answer from options and match case
        questions.append(getOptions(ques))
    return JSONResponse(content={
        "questions": questions
    })


@app.get('/learningMaterial')
async def learningMaterial(title: str = ''):
    topics = wikiPage(title)
    return topics


@app.get('/preloadedImages')
async def learningMaterial():
    return JSONResponse(content=IMAGES)


@app.post("/predictLabels")
async def predictLabels(req: Body):
    labels = detect_labels_uri(req.data)
    ids = map(lambda label: label['mid'], labels)
    topics = getMachineLabel(ids)
    titles = wikiPages(topics)
    return JSONResponse(content=titles)


# LABELS = [{'mid': '/m/0bwd_0j', 'description': 'Elephant', 'score': 0.975124, 'topicality': 0.975124, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}, {'mid': '/m/05s2s', 'description': 'Plant', 'score': 0.96498865, 'topicality': 0.96498865, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}, {'mid': '/m/06600f2', 'description': 'Plant community', 'score': 0.93969685, 'topicality': 0.93969685, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}, {'mid': '/m/0cblv', 'description': 'Ecoregion', 'score': 0.9285802, 'topicality': 0.9285802, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}, {'mid': '/m/07_gml', 'description': 'Working animal', 'score': 0.8963104, 'topicality': 0.8963104, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []},
#           {'mid': '/m/05nnm', 'description': 'Organism', 'score': 0.8622507, 'topicality': 0.8622507, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}, {'mid': '/m/03d28y3', 'description': 'Natural landscape', 'score': 0.8577174, 'topicality': 0.8577174, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}, {'mid': '/m/07kbbhf', 'description': 'Elephants and Mammoths', 'score': 0.84533, 'topicality': 0.84533, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}, {'mid': '/m/01jb4', 'description': 'Biome', 'score': 0.8243382, 'topicality': 0.8243382, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}, {'mid': '/m/04_r5c', 'description': 'African elephant', 'score': 0.8185059, 'topicality': 0.8185059, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}]
IMAGES = ['https://i.ibb.co/19dPN18/goose.jpg', 'https://i.ibb.co/6J7C2Rk/elephants.jpg', 'https://i.ibb.co/wpzWL7v/lion.jpg', 'https://i.ibb.co/JFfsTmc/canal.jpg', 'https://i.ibb.co/ccNDL2h/auto-shelby-1748c33f675-original-ratio.jpg',
          'https://i.ibb.co/hYk9zWp/croppedshutterstock439977091jpg-0.jpg', 'https://i.ibb.co/nwFXPkh/giraffe.jpg', 'https://i.ibb.co/HKHfLZv/penguins.jpg', 'https://i.ibb.co/N6SgqFn/AP21083627122061.jpg']
# QUESTIONS = [{'answer': '<pad> Elephants', 'question': 'What are the largest existing land animals?', 'context': 'Elephants are the largest existing land animals.'}, {'answer': '<pad> three', 'question': 'How many living species are elephants currently recognised?', 'context': 'Three living species are currently recognised: the African bush elephant, the African forest elephant, and the Asian elephant.'}, {'answer': '<pad> Elephantidae', 'question': 'What is the only surviving family of proboscideans?', 'context': 'They are an informal grouping within the proboscidean family Elephantidae.'}, {'answer': '<pad> mastodons', 'question': 'What are the extinct members of the proboscidean family?', 'context': 'Elephantidae is the only surviving family of proboscideans; extinct members include the mastodons.'}, {'answer': '<pad> mammoths and straight-tusked elephants', 'question': 'What are the extinct groups of elephantidae?', 'context': 'Elephantidae also contains several extinct groups, including the mammoths and straight-tusked elephants.'}, {'answer': '<pad> larger ears and concave backs', 'question': 'What do African elephants have?', 'context': 'African elephants have larger ears and concave backs, whereas Asian elephants have smaller ears, and convex or level backs.'},
#              {'answer': '<pad> a trunk, tusks, large ear flaps, massive legs, and tough but sensitive skin', 'question': 'What is a long proboscis called?', 'context': 'Distinctive features of all elephants include a long proboscis called a trunk, tusks, large ear flaps, massive legs, and tough but sensitive skin.'}, {'answer': '<pad> breathing, bringing food and water to the mouth, and grasping objects', 'question': 'What is the trunk used for?', 'context': 'The trunk is used for breathing, bringing food and water to the mouth, and grasping objects.'}, {'answer': '<pad> Tusks', 'question': 'What is derived from the incisor teeth?', 'context': 'Tusks, which are derived from the incisor teeth, serve both as weapons and as tools for moving objects and digging.'}, {'answer': '<pad> The large ear flaps', 'question': 'What aids in maintaining a constant body temperature?', 'context': 'The large ear flaps assist in maintaining a constant body temperature as well as in communication.'}, {'answer': '<pad> The pillar-like legs', 'question': 'What type of legs carry their great weight?',
#                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    'context': 'The pillar-like legs carry their great weight.'}, {'answer': '<pad> sub-Saharan Africa, South Asia, and Southeast Asia', 'question': 'Where are elephants scattered?', 'context': 'Elephants are scattered throughout sub-Saharan Africa, South Asia, and Southeast Asia and are found in different habitats, including savannahs, forests, deserts, and marshes.'}, {'answer': '<pad> herbivorous', 'question': 'What type of species are elephants found in savannahs, forests, deserts, and marshes?', 'context': 'They are herbivorous, and they stay near water when it is accessible.'}, {'answer': '<pad> their impact on their environments', 'question': 'What are elephants considered to be keystone species?', 'context': 'They are considered to be keystone species, due to their impact on their environments.'}, {'answer': '<pad> fission–fusion society', 'question': 'What type of society does elephants have?', 'context': 'Elephants have a fission–fusion society, in which multiple family groups come together to socialise.'}, {'answer': '<pad> Females (cows)', 'question': 'What group of females tend to live in family groups?', 'context': 'Females (cows) tend to live in family groups, which can consist of one female with her calves or several related females with offspring.'}, {'answer': '<pad> matriarch', 'question': 'What is the oldest cow called?', 'context': 'The groups, which do not include bulls, are usually led by the oldest cow, known as the matriarch.'}, {'answer': '<pad> Males (bulls)', 'question': 'Who leaves their family groups when they reach puberty?', 'context': 'Males (bulls) leave their family groups when they reach puberty and may live alone or with other males.'}, {'answer': '<pad> Adult bulls', 'question': 'What type of bulls interact with family groups when looking for a mate?', 'context': 'Adult bulls mostly interact with family groups when looking for a mate.'}, {'answer': '<pad> musth', 'question': 'What is a state of increased testosterone and aggression known as?', 'context': 'They enter a state of increased testosterone and aggression known as musth, which helps them gain dominance over other males as well as reproductive success.'}, {'answer': '<pad> Calves', 'question': 'What is the name of a female elephant?', 'context': 'Calves are the centre of attention in their family groups and rely on their mothers for as long as three years.'}]
if __name__ == '__main__':
    ngrok_tunnel = ngrok.connect(8000)
    print('Public URL:', ngrok_tunnel.public_url)
    nest_asyncio.apply()
    uvicorn.run(app, port=8000)
