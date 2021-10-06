from flask import Flask, jsonify, request
from google.cloud import vision
import proto


import flask
app = Flask(__name__)

###################################################


def pre_processing(text):
    return ' '
###################################################


def detect_labels_uri(uri):
    """Detects labels in the file located in Google Cloud Storage or on the
    Web."""
    client = vision.ImageAnnotatorClient()
    image = vision.Image()
    image.source.image_uri = uri

    response = client.label_detection(image=image)

    if response.error.message:
        raise Exception(
            '{}\nFor more info on error messages, check: '
            'https://cloud.google.com/apis/design/errors'.format(
                response.error.message))
    return [proto.Message.to_dict(tag) for tag in response.label_annotations]


@app.route('/')
def index():
    return "hello"  # flask.render_template('index.html')


@app.route('/predictLabels', methods=['POST'])
def predict():
    labels = detect_labels_uri(
        "https://upload.wikimedia.org/wikipedia/commons/7/73/Lion_waiting_in_Namibia.jpg")
    labels = jsonify(labels)
    print(labels)
    return labels


if __name__ == '__main__':
    #clf = joblib.load('quora_model.pkl')
    #count_vect = joblib.load('quora_vectorizer.pkl')
    app.run(debug=True)
    #app.run(host='localhost', port=8081)
