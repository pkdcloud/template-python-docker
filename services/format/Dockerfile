ARG BASE_IMAGE

FROM ${BASE_IMAGE}

ARG TOOL
ARG TOOL_VERSION

COPY ./services/format/pyproject.toml /app/pyproject.toml

RUN pip install ${TOOL}==${TOOL_VERSION}
