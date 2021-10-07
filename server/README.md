# Model_Deployment

This a demo for a machine learning model deployment using flask both locally and on a public server.
Kindly refer to the following blog for detialed explanation
https://towardsdatascience.com/model-deployment-using-flask-c5dcbb6499c9

pip install -r requirements.txt

cd your-project
python -m venv env

source env/bin/activate

deactivate

# always run this when opening a terminal

export GOOGLE_APPLICATION_CREDENTIALS="/Users/immentia/Desktop/QuizApp/server/keyFile.json"

uvicorn main:app --reload --workers 1 --host 0.0.0.0 --port 8008
