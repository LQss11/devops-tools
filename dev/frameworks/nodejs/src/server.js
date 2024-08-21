const express = require('express');
const database = require('./database').db; // Import the db instance directly
const logger = require('./logger');

// List of possible names
const names = ['Alice', 'Bob', 'Charlie', 'David', 'Eve'];

// Function to generate a random user
const generateRandomUser = (id) => ({
  id,
  name: names[Math.floor(Math.random() * names.length)],
  email: `user${id}@example.com`,
  age: Math.floor(Math.random() * (50 - 20 + 1)) + 20
});

// Function to generate a list of random users
const generateRandomUsers = (count) => {
  return Array.from({ length: count }, (_, i) => generateRandomUser(i + 1));
};

const app = express();

// Root API
app.get('/', async (req, res, next) => {
  try {
    const [result] = await database.raw('SELECT VERSION() AS version');
    res.json({ message: `Hello from MySQL ${result[0].version}` });
  } catch (error) {
    next(error);
  }
});

// Health check API
app.get('/healthz', (req, res) => {
  res.json({ message: 'I am happy and healthy' });
});

// API to retrieve a randomized list of users
app.get('/api/users', (req, res) => {
  const count = parseInt(req.query.count, 10) || 10; // Default to 10 users if count is not specified
  if (isNaN(count) || count <= 0) {
    return res.status(400).json({ error: 'Invalid count parameter. Must be a positive integer.' });
  }
  res.json(generateRandomUsers(count));
});

// API to get a user by ID
app.get('/api/users/:id', (req, res) => {
  const { id } = req.params;
  if (isNaN(id) || id <= 0) {
    return res.status(400).json({ error: 'Invalid ID parameter. Must be a positive integer.' });
  }

  const user = generateRandomUser(parseInt(id, 10));
  res.json(user);
});

// API to update user data
app.put('/api/users/:id', express.json(), (req, res) => {
  const { id } = req.params;
  const { name, email, age } = req.body;

  if (isNaN(id) || id <= 0) {
    return res.status(400).json({ error: 'Invalid ID parameter. Must be a positive integer.' });
  }

  if (!name || !email || !age) {
    return res.status(400).json({ error: 'Missing required fields: name, email, and age.' });
  }

  // Simulate updating the user
  const updatedUser = {
    id: parseInt(id, 10),
    name,
    email,
    age
  };

  res.json({ message: 'User updated successfully', user: updatedUser });
});

// API to delete a user
app.delete('/api/users/:id', (req, res) => {
  const { id } = req.params;

  if (isNaN(id) || id <= 0) {
    return res.status(400).json({ error: 'Invalid ID parameter. Must be a positive integer.' });
  }

  // Simulate deleting the user
  res.json({ message: `User with ID ${id} deleted successfully.` });
});

// API that throws an exception
app.get('/api/error1', (req, res, next) => {
  next(new Error('This is a simulated error for testing'));
});

// Another API that throws an exception
app.get('/api/error2', (req, res, next) => {
  const undefinedVariable = null;
  try {
    undefinedVariable.someMethod(); // This will throw an exception
  } catch (error) {
    next(error);
  }
});

// Error handling middleware
app.use((err, req, res, next) => {
  logger.error(`Error: ${err.message}`);
  res.status(500).json({ error: 'Something went wrong!', message: err.message });
});

module.exports = app;
