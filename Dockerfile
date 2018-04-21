FROM python:2-alpine

ADD requirements.txt /app/requirements.txt

RUN apk add --no-cache gcc zlib-dev build-base openjpeg-dev jpeg-dev python-dev musl-dev  \
            linux-headers libffi-dev postgresql-dev gettext
RUN pip install -r /app/requirements.txt && \
    apk del gcc python-dev linux-headers libffi-dev zlib-dev libjpeg-turbo-dev && \
    mkdir -p /app/{storage, static} && rm -rf /root/.cache/

ADD . /app/
WORKDIR /app/

EXPOSE 80

CMD sh /app/bin/docker-entrypoint.sh
