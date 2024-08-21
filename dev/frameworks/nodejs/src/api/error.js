const express = require('express');
const router = express.Router();

// API that throws an exception
router.get('/', (req, res, next) => {
  next(new Error('This is a simulated base error for testing'));
});
// API that throws an exception
router.get('/error1', (req, res, next) => {
  next(new Error('This is a simulated error for testing'));
});

// Another API that throws an exception
router.get('/error2', (req, res, next) => {
  const undefinedVariable = null;
  try {
    undefinedVariable.someMethod(); // This will throw an exception
  } catch (error) {
    next(error);
  }
});

module.exports = router;
