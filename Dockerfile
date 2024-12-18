FROM python:3.12-slim

WORKDIR /usr/src/app

ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache

RUN pip install poetry

COPY poetry.lock .
COPY pyproject.toml .

RUN poetry install --no-root && rm -rf $POETRY_CACHE_DIR

COPY . .

CMD ["sh", "-c", "poetry run uvicorn main:app --host 0.0.0.0 --port $PORT"]