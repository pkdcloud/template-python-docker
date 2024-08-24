ARG BASE_IMAGE

FROM ${BASE_IMAGE}

ARG TOOL
ARG TOOL_VERSION

#ENV PYTHONPATH /app

RUN apk add --no-cache bash coreutils

COPY ./app /app
COPY ./tests /app/tests
COPY ./services/test/pytest.ini /app/pytest.ini
COPY ./services/test/requirements.txt /app/requirements.txt

RUN pip install -r /app/requirements.txt
RUN pip install ${TOOL}==${TOOL_VERSION}

#WORKDIR /app
