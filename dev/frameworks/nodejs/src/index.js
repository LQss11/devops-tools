const express = require('express');
const logger = require('./logger');
const apiRoutes = require('./api/router'); // Import API routes
const { db, getDatabaseVersion } = require('./database'); // Import the db instance and getDatabaseVersion

const app = express();
const port = process.env.PORT || 3000;

// Middleware to parse JSON bodies
app.use(express.json());

// Use API routes
app.use('/api', apiRoutes);

// Root API
app.get('/', async (req, res, next) => {
  try {
    const version = await getDatabaseVersion(); // Use the function from database.js
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
