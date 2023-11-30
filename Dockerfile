FROM python:3.8.10-slim-buster
ADD . /python-flask
WORKDIR /python-flask
RUN pip install -r requirements.txt
CMD [ "python" , "./myapp.py" ]
