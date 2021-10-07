from fastapi import FastAPI
from google.cloud import vision
import proto
from pydantic import BaseModel

app = FastAPI()

###################################################


def pre_processing(text):
    return ' '
###################################################


class Image(BaseModel):
    image: str


def detect_labels_uri(content):
    """Detects labels in the file located in Google Cloud Storage or on the
    Web."""
    client = vision.ImageAnnotatorClient()
    image = vision.Image()

    response = client.label_detection(content=content)

    if response.error.message:
        raise Exception(
            '{}\nFor more info on error messages, check: '
            'https://cloud.google.com/apis/design/errors'.format(
                response.error.message))
    return [proto.Message.to_dict(tag) for tag in response.label_annotations]


@app.post("/predictLabels")
def predict(req: Image):
    print(req.image)
    labels = detect_labels_uri(req.image)
    return labels
