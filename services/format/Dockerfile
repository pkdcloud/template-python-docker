ARG BASE_IMAGE

FROM ${BASE_IMAGE}

ARG TOOL
ARG TOOL_VERSION

COPY ./services/format/pyproject.toml /app/pyproject.toml
COPY ./services/format/requirements.txt /app/requirements.txt

RUN pip install -r /app/requirements.txt
RUN pip install ${TOOL}==${TOOL_VERSION}
