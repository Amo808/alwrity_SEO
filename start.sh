#!/bin/bash
# Start script for Render
set -e

echo "🚀 Starting Lobe Chat server..."

# Set port (Render provides PORT env variable)
export PORT=${PORT:-10000}
echo "📡 Using port: $PORT"

# Ensure pnpm is available
echo "⚙️ Setting up pnpm..."
corepack enable
corepack prepare pnpm@latest --activate

# Start the server
echo "🌟 Starting Next.js server..."
pnpm start
