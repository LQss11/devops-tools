# Bumpversion release
The package used to manage versioning of this project is bumpversion which is a python package.

To increment version we can run the following commands:
```sh
# You can use patch/minor/major/hotfix
docker run -it --rm -v ${pwd}:/app -w /app python:alpine sh -c "pip install bumpversion && bumpversion minor --tag --commit --allow-dirty"
# You can use single line command without need of cfg or any file 
bumpversion minor --current-version 0.5.1 --list
```

> PS: Make sure that file **.bumpversion.cfg** exist in current directory