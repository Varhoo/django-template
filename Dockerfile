FROM python:2-alpine

RUN apk update && \
    apk add py-virtualenv && \
    virtualenv /data/app/.env

ADD requirements.txt /data/app/requirements.txt

RUN apk update && \
    apk add gcc zlib-dev libjpeg-turbo-dev python-dev musl-dev  \
            linux-headers libffi-dev postgresql-dev gettext
RUN source /data/app/.env/bin/activate && pip install -r /data/app/requirements.txt && \
    rm -rf /root/.cache/ && apk del gcc python-dev linux-headers libffi-dev && \
    mkdir -p /data/{storage, static}

ADD . /data/app/
WORKDIR /data/app/

EXPOSE 80

CMD sh /data/app/bin/docker-entrypoint.sh
