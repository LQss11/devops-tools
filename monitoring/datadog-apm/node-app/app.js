require('dd-trace').init({
  hostname: process.env.DD_AGENT_HOST,
  port: 8126,
  env: 'prod',
  logInjection: true,
  analytics: true,
});

const { createLogger, format, transports } = require('winston');
const addAppNameFormat = format(info => {
  info.ddtags = {'logging-mvp': 'dd-tracing-logging-examples-nodejs'};
  return info;
});
const logger = createLogger({
  level: 'info',
  exitOnError: false,
  format: format.combine(
    addAppNameFormat(),
    format.json(),
    ),
  transports: [
  new transports.Console(),
  ],
});

const { createProxyMiddleware } = require('http-proxy-middleware');
const app = require('express')()

app.get('/', function (req, res) {
  logger.log('info', 'A simple log that works with Datadog APM tracing and logging!');  
  res.send('Hello World!')
})

// // Add a new route to handle /hello-world/ and redirect
// app.get('/hello-world/', function (req, res) {
//   res.redirect('http://hello-world:8080/')
// })

// Use http-proxy-middleware to proxy /hello-world/ requests
app.use('/hello-world', createProxyMiddleware({
  target: 'http://hello-world:8080',
  changeOrigin: true
}));


app.listen(3000, '0.0.0.0', () => {
  console.log(`Server is running at http://0.0.0.0:3000`);
});
