ARG BASE_IMAGE
FROM ${BASE_IMAGE}

COPY . /app

WORKDIR /app

RUN pip install -r requirements.txt

ENTRYPOINT ["python"]

CMD ["main.py"]