```sh
# Run container with docker compose
docker-compose up -d 
# Release
docker exec -it python_release_example sh -c "git config --global user.email 'you@example.com'"
docker exec -it python_release_example sh -c "git config --global user.name 'Your Name'"
docker exec -it python_release_example sh -c "git add ."
docker exec -it python_release_example sh -c "bumpversion minor --dry-run --list"
docker exec -it python_release_example sh -c "git commit -m 'Setup Commit'"
docker exec -it python_release_example sh -c "bumpversion minor --commit"
docker exec -it python_release_example sh -c "bumpversion minor --tag"
```
# Run in a single command
```sh
# Run container with docker compose
docker run -it --rm -v ${pwd}:/app -w /app/app python:3.6.9 bash -c "pip install bumpversion && bumpversion minor"

```