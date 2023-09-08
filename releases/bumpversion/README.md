# Bumpversion release
The package used to manage versioning of this project is bumpversion which is a python package.

To increment version we can run the following commands:
```sh
# You can use pathc/minor/major/hotfix
docker run -it --rm -v ${pwd}:/app -w /app python:alpine sh -c "pip install bumpversion && bumpversion minor --tag --commit --allow-dirty"
```
