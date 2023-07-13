```sh
# Pre-Major Patch
docker run -it --rm -v ${pwd}/src:/app -w /app node:14-alpine sh -c "npm version premajor -m 'example premajor version'"
# Pre-Release
docker run -it --rm -v ${pwd}/src:/app -w /app node:14-alpine sh -c "npm version prerelease"
```