FROM python:2-alpine

ADD requirements.txt /app/requirements.txt

ENV PACKAGES="build-base postgresql-dev gettext"
ENV PACKAGES_DEV="zlib-dev libjpeg-turbo-dev python-dev linux-headers libffi-dev"

RUN apk add --no-cache $PACKAGES $PACKAGES_DEV && pip install -r /app/requirements.txt && \
    rm -rf /root/.cache/ && apk del $PACKAGES_DEV

ADD . /app/
WORKDIR /app/

EXPOSE 80

CMD sh /app/bin/docker-entrypoint.sh
