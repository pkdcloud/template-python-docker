ARG BASE_IMAGE

FROM ${BASE_IMAGE}

ARG TOOL
ARG TOOL_VERSION

# Copy the app and tests directories into the container
COPY ./app /app
COPY ./tests /app/tests

RUN pip install ${TOOL}==${TOOL_VERSION}
