# Python web server
Sometimes when we build a dist we want to test it real quick the quickest way is to use python web server you can run this command:
```sh
# Visit localhost:8080
docker run -it --rm --entrypoint="" -v ${pwd}/dist:/app -w /app -p 8080:8000 python:alpine sh -c "python3 -m http.server 8000"
```