import nltk
from nltk.stem import WordNetLemmatizer
from fastapi import FastAPI
from fastapi.responses import JSONResponse
from google.cloud import vision
import proto
from pydantic import BaseModel
import base64
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

import wikipedia_parser

config = dotenv_values(".env")

# nltk.download('wordnet')
# nltk.download('punkt')

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=['*'],
    allow_credentials=True,
    allow_methods=['*'],
    allow_headers=['*'],
)

nlp = question_generation.pipeline(
    "question-generation", model="valhalla/t5-small-qg-prepend", qg_format="prepend")

###################################################


def pre_processing(text):
    return ' '
###################################################


###################################################

def data_extractor(url):
    return ' '
###################################################


class Image(BaseModel):
    image: str


def getMachineLabel(id):
    headers = {
        'Accept': 'application/json',
    }
    print(config['GAPI_KEY'])
    params = (
        ('ids', [id]),
        ('key', config['GAPI_KEY']),
    )
    try:
        response = requests.get(
            'https://kgsearch.googleapis.com/v1/entities:search', headers=headers, params=params)
        url = response.json()[
            'itemListElement'][0]['result']['detailedDescription']['url']
        return url
    except requests.exceptions.RequestException as err:
        print(err)
        raise err


def detect_labels_uri(source):
    """Detects labels in the file located in Google Cloud Storage or on the Web."""
    client = vision.ImageAnnotatorClient()
    request = {
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


@app.get('/generateQuestions')
async def generateQuestions(id: str = '', name: str = ''):
    url = getMachineLabel(id)
    data = wikipedia_parser.wikipedia(url)
    print(data)
    # conceptsArr = wikipedia.search(concept)
    # page = wikipedia.page(conceptsArr[0])
    # # print(page.categories)
    # # print(page.title)
    # # print(page.images)
    # summary = page.summary
    # # summary = ' '.join(re.split(r'(?<=[.?!])\s+', summary, 5)[:-1])

    # print(summary)
    # start = time.time()
    # questions = nlp(summary)
    # end = time.time()
    # print((end - start))
    # return JSONResponse(content={
    #     "questions": questions
    # })


@app.post("/predictLabels")
async def predictLabels(req: Image):
    # labels = detect_labels_uri(req.image)
    return JSONResponse(content=LABELS)


LABELS = [{'mid': '/m/0bwd_0j', 'description': 'Elephant', 'score': 0.975124, 'topicality': 0.975124, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}, {'mid': '/m/05s2s', 'description': 'Plant', 'score': 0.96498865, 'topicality': 0.96498865, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}, {'mid': '/m/06600f2', 'description': 'Plant community', 'score': 0.93969685, 'topicality': 0.93969685, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}, {'mid': '/m/0cblv', 'description': 'Ecoregion', 'score': 0.9285802, 'topicality': 0.9285802, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}, {'mid': '/m/07_gml', 'description': 'Working animal', 'score': 0.8963104, 'topicality': 0.8963104, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []},
          {'mid': '/m/05nnm', 'description': 'Organism', 'score': 0.8622507, 'topicality': 0.8622507, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}, {'mid': '/m/03d28y3', 'description': 'Natural landscape', 'score': 0.8577174, 'topicality': 0.8577174, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}, {'mid': '/m/07kbbhf', 'description': 'Elephants and Mammoths', 'score': 0.84533, 'topicality': 0.84533, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}, {'mid': '/m/01jb4', 'description': 'Biome', 'score': 0.8243382, 'topicality': 0.8243382, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}, {'mid': '/m/04_r5c', 'description': 'African elephant', 'score': 0.8185059, 'topicality': 0.8185059, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}]


# if __name__ == '__main__':
#     ngrok_tunnel = ngrok.connect(8000)
#     print('Public URL:', ngrok_tunnel.public_url)
#     nest_asyncio.apply()
#     uvicorn.run(app, port=8000)
