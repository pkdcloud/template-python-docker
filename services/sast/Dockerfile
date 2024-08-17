FROM python:slim

RUN pip install bandit

WORKDIR /app

ENTRYPOINT ["bandit", "-r", "/app"]
