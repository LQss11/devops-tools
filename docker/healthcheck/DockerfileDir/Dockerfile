FROM nginx:latest

# Copy your application files to the appropriate location

# Set up the healthcheck
HEALTHCHECK \
    --interval=15s \
    --timeout=10s \
    --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Expose the necessary ports

# Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]
