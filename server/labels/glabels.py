from logging import error
import requests
from google.cloud import vision
import base64
import proto
from dotenv import dotenv_values

config = dotenv_values(".env")


def _parseMachineData(item):
    try:
        return item['result']['detailedDescription']['url'].split("/")[-1]
    except Exception as e:
        return None


def getMachineLabel(ids):
    headers = {
        'Accept': 'application/json',
    }

    # print(config['GAPI_KEY'])
    params = (
        ('ids', ids),
        ('key', config['GAPI_KEY']),
    )
    try:
        response = requests.get(
            'https://kgsearch.googleapis.com/v1/entities:search', headers=headers, params=params)
        topics = filter(None, map(_parseMachineData,
                        response.json()['itemListElement']))
        # print(*topics)
        return list(topics)
    except requests.exceptions.RequestException as err:
        print(err)
        raise err


def detect_labels_uri(source: str):
    """Detects labels in the file located in Google Cloud Storage or on the Web."""
    client = vision.ImageAnnotatorClient()
    request = {}
    if source.startswith('http'):
        gsLoc = source.replace('https://storage.googleapis.com/', 'gs://')
        request = {'image': {
            'source': {'image_uri': gsLoc},
        }}
    else:
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
