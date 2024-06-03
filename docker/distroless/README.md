# Distroless
Distroless containers doesn't have a shell by default so one way to debug is by running something like this:

```sh
# Run a container
docker build -t distroless-java-app .
docker run -it --rm --name distroless-java-app distroless-java-app
# Run debugger with 
docker run -it --rm --name debugger --pid container:distroless-java-app --network container:distroless-java-app ubuntu bash -c "ps aux"
# The output will look something like this
# root         1  1.2  0.5 4104040 28464 pts/0   Ssl+ 10:26   0:00 java Hello

# Using volumes from (if volume mount at /usr/src/app in distroless-java-app you ll find the same in this )
docker run -it --rm --name debugger --pid container:distroless-java-app --network container:distroless-java-app --volumes-from distroless-java-app ubuntu bash
```
