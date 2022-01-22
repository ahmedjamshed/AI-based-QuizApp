# Knowledge Aware Visual Question Answering Framework for developing visual learning apps for children

This project contains a server developed on python3 using FastAPI which is capable of generating multiple knowledge-aware, open-ended and free-formed MCQs from a single image. It also contains a mobile app developed on flutter which interacts with the server to help the children in learning by generating automated quizzes on their favorite topics.




## Architecture

The proposed architecture can be divided into four modules

![Modules](./imgs/ModModules.jpg)

##### 1. Image Labelling

This module is responsible for labelling the image using Google Cloud Vision.

![Image Labelling](./imgs/ModImageLabelling.jpg)


##### 2. Knowledge Parsing

This module is responsible for parsing the knowledge from Wikipedia.

![Knowledge Parsing](./imgs/ModKnowledgeExtraction.jpg)

##### 3. Questions Answers Extraction

This module is responsible for extracting the answer-aware questions using Google's T5 model fine-tuned on SQuAD dataset.

![QA Extraction](./imgs/ModQAExtraction.jpg)

##### 4. Relevant Options Creation

This module is responsible for generating relevant options using Sense2Vec to convert simple Questions into MCQs.

![Relevant Options](./imgs/ModRelevantOptions.jpg)


## Step-One: A Visual Learning App

Using the proposed framework, we were able to develop a visual learning app for children with the following screens.

##### 1. Image Input Screen

This module is responsible for labelling the image using Google Cloud Vision.

![Image Picker](./imgs/ImagePicker.jpg) ![Image Selection](./imgs/ImageSelection.jpg)


##### 2. Topic Selection Screen

This module is responsible for parsing the knowledge from Wikipedia.

![Label Selection](./imgs/LabelSelection.jpg) ![Another Label Selection](./imgs/LabelSelection2.jpg)

##### 3. Reading Screen

This module is responsible for extracting the answer-aware questions using Google's T5 model fine-tuned on SQuAD dataset.

![Label Page](./imgs/LabelPage.jpg) ![Another Label Page](./imgs/LabelPage2.jpg)

##### 4. Quiz Screen

This module is responsible for generating relevant options using Sense2Vec to convert simple Questions into MCQs.

![Quiz Screen](./imgs/Quiz1.jpg) ![Context Screen](./imgs/Context1.jpg)

##### 5. Score Screen

This module is responsible for generating relevant options using Sense2Vec to convert simple Questions into MCQs.

![Good Score](./imgs/scoreGood.jpg) ![Bad Score](./imgs/scoreBad.jpg)

## Installation


##### Environment
To setup the environment, run:
```sh
cd QuizApp/server
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
```

##### Dependencies
To install dependencies:

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

[![Colab Notebook](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/gist/ahmedjamshed/1c8663cd4f24748eaf96a0b5bedd54de/quizappserver.ipynb)

To Run App...

make sure server endpoint is updated in [constants.dart](./lib/app/common/constants.dart)

```sh
flutter run
```

## License

MIT
