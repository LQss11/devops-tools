# Openshift 
A tool to manage all envs
# Get started
## Sandbox
You can start using openshift using a Sandbox created in the cloud if your computer isn't good engough to run a cluste
- Go to the [sandbox url](https://console.redhat.com/openshift/sandbox) but make sure to not run anything in production on it since it ll be disabled in 30 days since it's a sandbox.
## Code ready containers (CRC)
1. Create red-hat account
2. Once you sign in go to [redshift-console-url](https://console.redhat.com/openshift)
3. Click on [create cluster](https://console.redhat.com/openshift/create)
4. Select Local and download the right file depending on your OS
5. Once downloaded install crc and restart
6. Now run `crc setup` (make sure that you run it in powershell as administrator)
7. Once it downloads and it's ready you can run `crc start` to start the cluster and you can check the hyper-v where a new vm will be created (Make sure to run in non admin console)
7. Insert the Pull secret from this [link](https://console.redhat.com/openshift/create/local)
8. Now you can see crc is running in the task bar
9. Right click it -> Open console
10. Run `crc console --credentials` to get credentials where you can type the to access your cluster online then run `crc console`  

# Connect from local cli
Get token from this [URL](https://console.redhat.com/openshift/token)
Run the following command or install Openshift CLI from this url:
```sh
crc console --credentials
docker run -it --rm --name=origin-cli openshift/origin-cli bash
oc login --token="" -u "username" -p "password" "ClusterURL"
```