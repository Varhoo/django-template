FROM python:2-alpine

ADD requirements.txt /app/requirements.txt

ENV PACKAGES="build-base zlib-dev libjpeg-turbo-dev python-dev postgresql-dev \
              linux-headers libffi-dev gettext"

RUN apk add --no-cache $PACKAGES && pip install -r /app/requirements/requirements.txt && \
    rm -rf /root/.cache/ && apk del gcc python-dev linux-headers libffi-dev python-dev

ADD . /app/
WORKDIR /app/

EXPOSE 80

CMD sh /app/bin/docker-entrypoint.sh
