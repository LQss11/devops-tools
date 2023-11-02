# Python flask
You can either run this flask app by running:

```sh
# Build image
docker build -t flask:app .
docker run -ti --rm -v ${pwd}:/app -p 5600:5000 flask:app bash
# This is used for dev
flask run --host=0.0.0.0 --port=5000
# This is used for prod
gunicorn --bind 0.0.0.0:5000 wsgi:app
```
## Docker compose
You can simply run this directly using docker compose cli:
```sh
docker-compose up -d --build
```