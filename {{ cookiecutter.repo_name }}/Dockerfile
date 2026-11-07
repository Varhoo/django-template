# ---- builder: compile dependencies (toolchain stays out of the final image) ----
FROM python:3.13-alpine AS builder

RUN apk add --no-cache build-base linux-headers

ENV PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt \
    && find /opt/venv -type d -name __pycache__ -prune -exec rm -rf {} + \
    && find /opt/venv -type d \( -name tests -o -name test \) -prune -exec rm -rf {} + \
    && rm -rf /opt/venv/lib/python*/site-packages/pip* /opt/venv/lib/python*/site-packages/setuptools*

# ---- runtime: only what is needed to run the app ----
FROM python:3.13-alpine

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/opt/venv/bin:$PATH"

RUN apk add --no-cache gettext

COPY --from=builder /opt/venv /opt/venv

WORKDIR /app/
COPY . /app/

EXPOSE 80

CMD ["sh", "/app/bin/docker-entrypoint.sh"]
