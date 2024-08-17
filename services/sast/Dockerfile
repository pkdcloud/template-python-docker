ARG BASE_IMAGE

FROM ${BASE_IMAGE}

ARG TOOL
ARG TOOL_VERSION

COPY ./app /app
COPY ./tests /app/tests
COPY ./services/sast/requirements.txt /app/requirements.txt

RUN pip install -r /app/requirements.txt
RUN pip install ${TOOL}==${TOOL_VERSION}
