FROM python:3.7.15-alpine
WORKDIR /server
COPY server /server
RUN apk update && pip install -U -r requirements.txt &&  python3 -m venv ~/virtualenvs/remote_state
CMD [ "python", "/server/stateserver.py" ]

