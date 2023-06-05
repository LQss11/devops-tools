# Jenkins
In this repo you can find some helpful jenkins tips and tricks that you could use in your workloads.
## Dockerfile
Usually I use docker to implement CI CD on my env so in order to do that I am adding several useful information in that dockerfile where I could workaround with my jenkins env
### Jenkins Permissions
If you have encountred issue about access, usually it's related to the user process running the jenkins process and sometimes that user wouldn't be able to do some actions or access files so you will need to provide him with certain permissions you can use `chown` or `chmod` like so:
```sh
# Change ownership to a whole directory
chown user:group -R /path/to/dir
# Change ownership to a single file
chown user:group /path/to/file
```
```sh
# Careful with the value after chmod
# You will need to only give what's needed
# Change ownership to a whole directory
chmod 744 -R /path/to/dir
# Change ownership to a single file
chmod 744 /path/to/file
```
An in your case since you're dealing with jenkins usually you can either find the directory of jenkins data under:

- Default path: `/var/lib/jenkins/`
- Env var (usually defined like that in a docker container): `JENKINS_HOME=/var/jenkins_home`
- In case you have access to the configuration page, you can find it on the header as **Home directory** : `http://localhost:8080/configure`
