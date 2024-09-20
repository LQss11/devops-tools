const express = require('express');
const logger = require('./logger');
const apiRoutes = require('./api/router');
const { getDatabaseVersion } = require('./database');

const app = express();
const port = process.env.PORT || 3000;

// Middleware to parse JSON bodies
app.use(express.json());

// Middleware for logging requests and responses
app.use((req, res, next) => {
  const start = Date.now();
  logger.info(`Request ${req.method} ${req.originalUrl} started`);

  // Capture the original send function
  const originalSend = res.send;

  res.send = function (body) {
    const duration = Date.now() - start;
    logger.info(`Response ${req.method} ${req.originalUrl} ${res.statusCode} - ${duration}ms`);
    res.send = originalSend; // Restore original send function
    return res.send(body);
  };

  next();
});

// Use API routes
app.use('/api/examples', apiRoutes);

// Root API
app.get('/api', async (req, res, next) => {
  try {
    const version = await getDatabaseVersion();
    res.json({ message: `Hello from MySQL ${version}` });
  } catch (error) {
    next(error);
  }
});

// Health check API
app.get('/healthz', (req, res) => {
  res.json({ message: 'I am happy and healthy' });
});

// Error handling middleware
app.use((err, req, res, next) => {
  logger.error(`Error: ${err.message}`);
  res.status(500).json({ error: 'Something went wrong!', message: err.message });
});

// Start server
const server = app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

// Graceful shutdown on SIGINT and SIGTERM
const shutdown = () => {
  server.close((err) => {
    if (err) {
      logger.error(`Server close error: ${err.message}`);
      process.exit(1);
    }
    logger.info('Server shut down gracefully');
    process.exit(0);
  });
};

process.on('SIGINT', () => {
  logger.info('Got SIGINT (Ctrl-C in Docker). Graceful shutdown');
  shutdown();
});

process.on('SIGTERM', () => {
  logger.info('Got SIGTERM (Docker container stop). Graceful shutdown');
  shutdown();
});
