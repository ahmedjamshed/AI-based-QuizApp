# Knowledge Aware Visual Question Answering Framework for developing visual learning apps for children

This project contains a server developed on python3 using FastAPI which is capable of generating multiple knowledge-aware, open-ended and free-formed MCQs from a single image. It also contains a mobile app developed on flutter which interacts with the server to help the children in learning by generating automated quizzes on their favorite topics.




## Architecture

The proposed architecture can be divided into four modules

![Modules](./imgs/ModModules.jpeg)

#### Image Labelling

![Image Labelling](./imgs/ModImageLabelling.jpeg)

## Installation


Install the dependencies and start the server.

```sh
cd your-project
python -m venv env
source env/bin/activate
pip install -r requirements.txt
```

Dependencies...

```sh
pip3 install sense2vec
pip3 install -U pip setuptools wheel
pip3 install -U spacy
python3 -m spacy download en_core_web_sm

pip3 install spacy-wordnet
python3 -m nltk.downloader wordnet

python -m spacy download en_core_web_sm
pip3 install -e git://github.com/ahmedjamshed/question_generation.git@0.4.0#egg=question_generation

```

Run Once..

```sh
python3 dloader.py

export GOOGLE_APPLICATION_CREDENTIALS="/Users/[user_name]/Desktop/QuizApp/server/keyFile.json"
```

To Run server...

```sh
cd server
uvicorn main:app --reload --workers 1 --host 0.0.0.0 --port 8008
```

OR

you can run 'server/quizAppServer' on colab and get the endpoint via ngrok

To Run App...

make sure server endpoint is updated in 'lib/app/common/constants.dart'

```sh
flutter run
```

## License

MIT
