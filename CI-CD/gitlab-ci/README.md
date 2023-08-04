# GITLAB
Following this example allows you to create a gitlab instance ready to be deployed using docker.
# Docker
```sh
docker-compose up -d
# Visit http://localhost:8080
```
once you made the instance is up and ready you can run:
```sh
docker exec -it ee63fcb857fb grep 'Password:' /etc/gitlab/initial_root_password
```
and now you can login as **root** user using the output password.

# Gitlab rails (cli tool)
You can mangae the gitlab instance using cli, to manage repos, users, privileges and more using gitlab-rails console. In order to do that you can run:
```sh
# This might take a few minutes to start a rails terminal
sudo gitlab-rails console -e production
# once ready you should see something like this as a shell "irb(main):001:0>"
```
Here are some commands examples
```sh
# Create a new user
new_user = User.new(username: 'newuser', name: 'New User', email: 'newuser@example.com', password: 'password', password_confirmation: 'password')
new_user.skip_confirmation!
new_user.save!

# Give admin permission to a user
user = User.find_by(username: 'newuser')
user.admin = true
user.save

# Destroy user
user.destroy

```

# Docs
for more information on how to set you instance and understand more preoblematic use cases make sure to check the official gitlab [documentation for docker](https://docs.gitlab.com/ee/install/docker.html).
