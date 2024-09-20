const express = require('express');
const router = express.Router();
const logger = require('../logger');

// API that throws an exception
router.get('/', (req, res, next) => {
  logger.error('Simulated base error');
  next(new Error('This is a simulated base error for testing'));
});

// API that throws an exception
router.get('/error1', (req, res, next) => {
  logger.error('Simulated error 1');
  next(new Error('This is a simulated error for testing'));
});

// Another API that throws an exception
router.get('/error2', (req, res, next) => {
  try {
    const undefinedVariable = null;
    undefinedVariable.someMethod(); // This will throw an exception
  } catch (error) {
    logger.error('Simulated error 2');
    next(error);
  }
});

module.exports = router;
