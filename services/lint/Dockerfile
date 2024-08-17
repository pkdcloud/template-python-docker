ARG BASE_IMAGE

FROM ${BASE_IMAGE}

ARG TOOL
ARG TOOL_VERSION

COPY ./app /app
COPY ./tests /app/tests
COPY ./services/lint/.flake8 /app/.flake8

RUN pip install ${TOOL}==${TOOL_VERSION}
