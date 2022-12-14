# AWS Credentials
## Create user secrets
First you need to create a new aws token:
* Login with your account
* Go to IAM then select Users
* Click on Add users
* Select AWS credential  (Access key - Programmatic access)
* Attache the required security group for the new user

Once the new user has been created an **Access key ID** and a **Secret access key** will be generated (make sure to store the secret access key somewhere before hitting next)

## Authentication
Credentials can be provided by using the **AWS_ACCESS_KEY_ID**, **AWS_SECRET_ACCESS_KEY**, and optionally **AWS_SESSION_TOKEN** environment variables. The region can be set using the **AWS_REGION** or **AWS_DEFAULT_REGION** environment variables.
```sh
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
export AWS_REGION="us-west-2"
```
Other environment variables related to authorization are:

* **AWS_PROFILE**
* **AWS_CONFIG_FILE**
* **AWS_SHARED_CREDENTIALS_FILE**