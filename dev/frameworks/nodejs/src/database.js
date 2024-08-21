const knex = require('knex');
const { database } = require('./config'); // Ensure this path is correct
const logger = require('./logger');

// Initialize Knex with MySQL2 client
const db = knex({
  client: 'mysql2',
  connection: database
});

// Function to get the database version
const getDatabaseVersion = async () => {
  try {
    const [result] = await db.raw('SELECT VERSION() AS version');
    return result[0].version;
  } catch (error) {
    logger.error(`Error fetching database version: ${error.message}`);
    throw new Error(`Error fetching database version: ${error.message}`);
  }
};

// Test the database connection on application startup
const testConnection = async () => {
  try {
    const version = await getDatabaseVersion();
    logger.info(`Database connected successfully. Version: ${version}`);
  } catch (error) {
    logger.error(`Failed to connect to the database: ${error.message}`);
    process.exit(1); // Exit the process with failure code
  }
};

testConnection();

module.exports = {
  db, // Export the db instance
  getDatabaseVersion
};
