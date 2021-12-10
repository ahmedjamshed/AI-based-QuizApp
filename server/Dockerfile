FROM tiangolo/uvicorn-gunicorn-fastapi:python3.7
WORKDIR /app
COPY . /app
RUN pip3 install --default-timeout=100 -r requirements.txt
RUN pip3 install -e git+https://github.com/ahmedjamshed/question_generation.git@0.2.0#egg=question_generation
RUN python3 -m nltk.downloader wordnet
ADD https://github.com/explosion/sense2vec/releases/download/v1.0.0/s2v_reddit_2015_md.tar.gz /app
RUN tar -xzf s2v_reddit_2015_md.tar.gz && rm s2v_reddit_2015_md.tar.gz
EXPOSE 5000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]