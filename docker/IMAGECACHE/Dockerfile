# syntax = docker/dockerfile:experimental
# for older docker version 18 to 20 export DOCKER_BUILDKIT="1"
###############
# First stage #
###############
FROM python:3.10.9-slim AS builder
# Setup env vars for builder
ENV LANG=C.UTF-8
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

COPY requirements.txt .
# Install Python dependencies
RUN --mount=type=cache,mode=0755,target=/root/.cache/pip \
    --mount=type=cache,mode=0755,target=/venv \
    python -m venv /venv && \
    . /venv/bin/activate && \ 
    pip install --prefix=/venv/ -r requirements.txt && \
    mkdir /output && cp -r /venv/* /output/


FROM python:3.10.9-slim AS final

# Add /venv/bin to the system PATH
ENV PATH="/venv/bin/:$PATH"

# Prepare a Python virtual environment at /venv
RUN python -m venv /venv

WORKDIR /usr/src/app
EXPOSE 8501

RUN apt-get update -yqqq && apt-get -yqqq install unixodbc-dev curl wget gpg gnupg
# Install sqlserver driver
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get -yqqq update && \
    ACCEPT_EULA=Y apt-get install -yqqq msodbcsql17

# Copy binaries/libraries
COPY --from=builder /output /venv

# Copy source code
COPY . .

CMD [ "streamlit", "run", "chatbot.py" , "--server.address=0.0.0.0", "--server.port=8501"]

