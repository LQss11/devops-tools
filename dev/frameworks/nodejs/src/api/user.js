const express = require('express');
const router = express.Router();

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

// API to retrieve a randomized list of users
router.get('/', (req, res) => {
  const count = parseInt(req.query.count, 10) || 10; // Default to 10 users if count is not specified
  if (isNaN(count) || count <= 0) {
    return res.status(400).json({ error: 'Invalid count parameter. Must be a positive integer.' });
  }
  res.json(generateRandomUsers(count));
});

// API to get a user by ID
router.get('/:id', (req, res) => {
  const { id } = req.params;
  if (isNaN(id) || id <= 0) {
    return res.status(400).json({ error: 'Invalid ID parameter. Must be a positive integer.' });
  }

  const user = generateRandomUser(parseInt(id, 10));
  res.json(user);
});

// API to update user data
router.put('/:id', express.json(), (req, res) => {
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
router.delete('/:id', (req, res) => {
  const { id } = req.params;

  if (isNaN(id) || id <= 0) {
    return res.status(400).json({ error: 'Invalid ID parameter. Must be a positive integer.' });
  }

  // Simulate deleting the user
  res.json({ message: `User with ID ${id} deleted successfully.` });
});

module.exports = router;
