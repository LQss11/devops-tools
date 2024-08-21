const express = require('express');
const userRoutes = require('./user');
const errorRoutes = require('./error');

const router = express.Router();

// Use user routes
router.use('/users', userRoutes);

// Use error routes
router.use('/errors', errorRoutes);

module.exports = router;
