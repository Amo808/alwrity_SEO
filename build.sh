#!/bin/bash
# Build script for Render
set -e

echo "🚀 Starting build process..."

# Enable corepack and setup pnpm
echo "⚙️ Setting up pnpm..."
corepack enable
corepack prepare pnpm@latest --activate

# Clean cache to avoid corruption
echo "🧹 Cleaning cache..."
rm -rf .next
rm -rf node_modules/.cache

# Install dependencies
echo "📦 Installing dependencies..."
pnpm install --frozen-lockfile --prefer-offline

# Build the application
echo "🏗️ Building application..."
NODE_OPTIONS="--max-old-space-size=6144" pnpm run build

echo "✅ Build completed successfully!"
