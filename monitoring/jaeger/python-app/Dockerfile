FROM python:3.10-alpine
ENV OTEL_SERVICE_NAME=python-app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY jaeger_tracing.py .
ENTRYPOINT [ "python", "jaeger_tracing.py"]