#!/bin/bash
# Start script for Lobe Chat on Render

echo "Starting Lobe Chat..."

# Set default port if not set
export PORT=${PORT:-10000}

# Start the application
npm start
