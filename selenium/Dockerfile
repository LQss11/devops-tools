FROM python:3.10-slim


# Installing Unzip
RUN apt-get update
RUN apt-get install -yq unzip curl wget

# Download the Chrome Driver
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/$(curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE)/chromedriver_linux64.zip

# Unzip the Chrome Driver into /usr/local/bin directory
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/
RUN rm -rf /tmp/*

WORKDIR /usr/src/app
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY . .

# Set display port as an environment variable
# ENV DISPLAY=:99
# RUN pip install -r requirements.txt
# RUN apt-get install libglib2.0-0 libx11-6 libnss3 -y
# ENV DISPLAY=:9515
# EXPOSE 9515