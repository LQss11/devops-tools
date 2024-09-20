# Angular
To create an Angular app you can simply run this command:
```sh
docker run --rm -it -v ${pwd}:/app -w /app node:alpine sh -c "npm install -g @angular/cli && ng new my-angular-project --defaults"
```