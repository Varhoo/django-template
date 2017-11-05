FROM python:2-alpine

RUN apk update && \
    apk add py-virtualenv && \
    virtualenv /data/.env

ADD requirements.txt /data/requirements.txt

RUN apk update && \
    apk add gcc zlib-dev libjpeg-turbo-dev python-dev musl-dev  \
            linux-headers libffi-dev postgresql-dev gettext
RUN source /data/.env/bin/activate && pip install -r /data/requirements.txt && \
    rm -rf /root/.cache/ && apk del gcc python-dev linux-headers libffi-dev python-dev && \
    mkdir -p /data/proj/storage

ADD . /data/
WORKDIR /data/

EXPOSE 80

CMD sh /data/bin/docker-entrypoint.sh
