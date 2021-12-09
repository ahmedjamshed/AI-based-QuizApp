# Model_Deployment

This a demo for a machine learning model deployment using flask both locally and on a public server.
Kindly refer to the following blog for detialed explanation
https://towardsdatascience.com/model-deployment-using-flask-c5dcbb6499c9

cd your-project
python -m venv env

source env/bin/activate

deactivate

pip install -r requirements.txt

# spacy

pip3 install sense2vec
pip3 install -U pip setuptools wheel
pip3 install -U spacy
python3 -m spacy download en_core_web_sm

# wordnet

pip3 install spacy-wordnet
python3 -m nltk.downloader wordnet
python3 -m nltk.downloader omw

# always run this when opening a terminal

export GOOGLE_APPLICATION_CREDENTIALS="/Users/immentia/Desktop/QuizApp/server/keyFile.json"
export GOOGLE_APPLICATION_CREDENTIALS="/Users/ahmedjamshed/Desktop/projects/QuizApp/server/keyFile.json"

uvicorn main:app --reload --workers 1 --host 0.0.0.0 --port 8008

# dependencies

python -m spacy download en_core_web_sm
pip3 install -e git://github.com/ahmedjamshed/question_generation.git@0.2.0#egg=question_generation

# For m1 mac

brew install miniforge
conda create -n quizapp pip
conda activate quizapp
conda install scikit-learn
conda install -c pytorch pytorch torchvision
conda install transformers  
conda install sentencepiece
pip install git+https://github.com/ahmedjamshed/question_generation.git@56f4963f20b19964cf6f496072a5eb35db0c3af6#egg=question_generation
