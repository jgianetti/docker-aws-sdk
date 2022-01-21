FROM python:3.10.2-slim-bullseye

ARG UID
ENV UID=${UID:-1000}

RUN set -x \
    && adduser --disabled-password --gecos "" developer \
    && mkdir /app \
    && chown -R developer:developer /app

USER developer

ENV VIRTUAL_ENV=/app/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN python3 -m pip install --upgrade pip

WORKDIR /app
COPY --chown=developer:developer code/requirements.txt code/requirements.txt
RUN python3 -m pip install -r code/requirements.txt
COPY --chown=developer:developer code code

WORKDIR /app/code

CMD ["python3", "main.py"]
