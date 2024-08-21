const fs = require('fs');

// Function to read a file and return its content
const readFileSync = filename => fs.readFileSync(filename).toString('utf8');

// Configuration constants
module.exports = {
  database: {
    host: process.env.DATABASE_HOST || 'localhost',
    port: process.env.DATABASE_PORT || 3306,
    database: process.env.DATABASE_DB || 'test',
    user: process.env.DATABASE_USER || 'root',
    password: process.env.DATABASE_PASSWORD || null
  },
  port: process.env.PORT || 3000 // Default port
};
