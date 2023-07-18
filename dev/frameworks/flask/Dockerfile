FROM python:3.10.10-slim

WORKDIR /tmp

# The ENV VIRTUAL_ENV and PATH environment variables are used to activate 
# the virtual environment so each RUN command runs properly in a venv.
# Set up and activate virtual environment
ENV VIRTUAL_ENV "/venv"
RUN python -m venv $VIRTUAL_ENV
ENV PATH "$VIRTUAL_ENV/bin:$PATH"
    
WORKDIR /usr/src/app

ENV FLASK_APP=app.py

ENV FLASK_ENV=development

COPY requirements.txt .

# Python commands run inside the virtual environment
RUN python -m pip install -r requirements.txt

COPY . .

CMD [ "flask", "run", "--host=0.0.0.0", "--port=5000" ]