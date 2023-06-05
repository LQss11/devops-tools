The following Urls will help you out with your jenkins credentials:
 
- Manage your credentials: `http://localhost:8080/credentials/`
- Run groovy scripts: `http://localhost:8080/script/`



## Permission
Without permissions to access certain files you will get this error:
```sh
java.nio.file.AccessDeniedException: /root/.kube/config
```
By default if you are running this as a jenkins user (as in a docker container), you will need to give that user permissions to access specific files, say you want to read the kubeconfig ?
```sh
chown -R jenkins:jenkins /root/.kube/
```