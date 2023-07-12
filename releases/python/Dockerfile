FROM python:3.6.9-slim

WORKDIR /usr/src/app

# The ENV VIRTUAL_ENV and PATH environment variables are used to activate 
# the virtual environment so each RUN command runs properly in a venv.
# Set up and activate virtual environment
ENV VIRTUAL_ENV "/venv"
RUN python -m venv $VIRTUAL_ENV
ENV PATH "$VIRTUAL_ENV/bin:$PATH"

RUN apt-get update && \
    apt-get install git

COPY app .


# Python commands run inside the virtual environment
RUN python -m pip install -r requirements.txt

# We can install without requirements.txt
# RUN python -m pip install packages1 packages2 ...

CMD [ "python", "setup.py" ]