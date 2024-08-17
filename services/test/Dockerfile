FROM python:slim

ARG TEST_FRAMEWORK=pytest
ARG TEST_FRAMEWORK_VERSION=8.3.2
ARG TEST_CONFIG_FILE=pytest.ini

RUN pip install ${TEST_FRAMEWORK}==${TEST_FRAMEWORK_VERSION}

WORKDIR /app

COPY ${TEST_CONFIG_FILE} .
COPY requirements.txt .

RUN pip install -r requirements.txt

ENTRYPOINT ["pytest"]
CMD ["."]