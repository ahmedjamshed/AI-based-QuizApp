from fastapi import FastAPI
from fastapi.encoders import jsonable_encoder
from fastapi.responses import JSONResponse
from google.cloud import vision
import proto
from pydantic import BaseModel
import base64

app = FastAPI()

###################################################


def pre_processing(text):
    return ' '
###################################################


class Image(BaseModel):
    image: str


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


@app.post("/predictLabels")
def predict(req: Image):
    # labels = detect_labels_uri(req.image)
    return JSONResponse(content=jsonable_encoder(LABELS))


LABELS = [{'mid': '/m/0bwd_0j', 'description': 'Elephant', 'score': 0.975124, 'topicality': 0.975124, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}, {'mid': '/m/05s2s', 'description': 'Plant', 'score': 0.96498865, 'topicality': 0.96498865, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}, {'mid': '/m/06600f2', 'description': 'Plant community', 'score': 0.93969685, 'topicality': 0.93969685, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}, {'mid': '/m/0cblv', 'description': 'Ecoregion', 'score': 0.9285802, 'topicality': 0.9285802, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}, {'mid': '/m/07_gml', 'description': 'Working animal', 'score': 0.8963104, 'topicality': 0.8963104, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []},
          {'mid': '/m/05nnm', 'description': 'Organism', 'score': 0.8622507, 'topicality': 0.8622507, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}, {'mid': '/m/03d28y3', 'description': 'Natural landscape', 'score': 0.8577174, 'topicality': 0.8577174, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}, {'mid': '/m/07kbbhf', 'description': 'Elephants and Mammoths', 'score': 0.84533, 'topicality': 0.84533, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}, {'mid': '/m/01jb4', 'description': 'Biome', 'score': 0.8243382, 'topicality': 0.8243382, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}, {'mid': '/m/04_r5c', 'description': 'African elephant', 'score': 0.8185059, 'topicality': 0.8185059, 'locale': '', 'confidence': 0.0, 'locations': [], 'properties': []}]
