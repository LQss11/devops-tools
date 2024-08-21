const { createLogger, format, transports } = require('winston');

// Custom format to add the application name
const addAppNameFormat = format((info) => {
  info.appName = 'backend-test';
  return info;
});

// Function to determine and return the logging format
const getLoggingFormat = () => {
  const loggingFormat = process.env.LOGGING_FORMAT;

  switch (loggingFormat) {
    case 'json':
      return format.combine(
        addAppNameFormat(),
        format.json()
      );

    case 'simple':
      return format.combine(
        format.printf(({ level, message, appName }) => {
          return `[${level.toUpperCase()}]${appName ? ` [${appName}]` : ''}: ${message}`;
        })
      );

    case 'timestamped':
      return format.combine(
        format.timestamp(),
        format.printf(({ timestamp, level, message, appName }) => {
          return `${timestamp} [${level.toUpperCase()}]${appName ? ` [${appName}]` : ''}: ${message}`;
        })
      );

    default:
      return format.combine(
        format.timestamp(),
        format.printf(({ timestamp, level, message, appName }) => {
          return `${timestamp} [${level.toUpperCase()}]${appName ? ` [${appName}]` : ''}: ${message}`;
        })
      );
  }
};

// Create and export the logger
const logger = createLogger({
  level: 'info',
  exitOnError: false,
  format: getLoggingFormat(),
  transports: [
    new transports.Console(),
    new transports.File({ filename: 'app.log' })
  ],
});

module.exports = logger;
