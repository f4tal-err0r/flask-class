## The base container image we're using
FROM python:3.8 

WORKDIR /app

## Install Python library dependencies
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY ./test /test

## Install database
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y sqlite3 libsqlite3-dev
RUN mkdir /db

WORKDIR /app/db

## Populate database and create tables
RUN /usr/bin/sqlite3 blog.db < /test/schema.sql
RUN /usr/bin/sqlite3 blog.db

WORKDIR /app

COPY . .

## Run the webapp
CMD [ "python", "-m" , "flask", "run", "--host=0.0.0.0", "--port=8080"]