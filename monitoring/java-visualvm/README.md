# Visualvm
A profiler tool to monitor java projects. 
# Quick Start
make sure jdk exist and make sure that DISPLAY environment variable is set properly and X11 is running on that ip address (in my case I am using mobaxterm X11).

```sh
# Build image
docker build -t visualvm .
# run image
docker run -it --rm --name visualvm -e DISPLAY="192.168.1.222:0.0" visualvm
# run visualvm
docker exec -it visualvm bash -c "visualvm"
# run application (java process)
docker exec -it visualvm bash -c "java Main"
# Delete container
docker stop visualvm
docker rm visualvm
```