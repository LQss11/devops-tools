// Add this to the VERY top of the first file loaded in your app
const apm = require('elastic-apm-node').start({
  // Override service name from package.json
  // Allowed characters: a-z, A-Z, 0-9, -, _, and space
  serviceName: 'test',

  // // Use if APM Server requires a token
  // secretToken: '',

  // // Use if APM Server uses API keys for authentication
  // apiKey: '',

  // Set custom APM Server URL (default: http://127.0.0.1:8200)
  serverUrl: 'http://host.docker.internal:8200',
})

const app = require('express')()

app.get('/', function (req, res) {
  res.send('Hello World!')
})
app.listen(3000, '0.0.0.0', () => {
  console.log(`Server is running at http://0.0.0.0:3000`);
});
