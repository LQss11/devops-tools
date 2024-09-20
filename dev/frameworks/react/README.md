# React
To create a React app you can simply run this command:
```sh
# Create the project
docker run --rm -it -v ${pwd}:/app -w /app node:alpine sh -c "npm install -g create-react-app && npx create-react-app frontend-test"
docker run --rm -it -v ${pwd}:/app -w /app -p 3000:3000 node:alpine sh -c "npm install react-router-dom"
# Start the project
docker run --rm -it -v ${pwd}:/app -w /app -p 3000:3000 node:alpine sh -c "npm run start"
```