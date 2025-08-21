#!/bin/bash
# Build script for Render

echo "Installing pnpm..."
corepack enable pnpm

echo "Installing dependencies..."
pnpm install --frozen-lockfile

echo "Building the application..."
pnpm run build

echo "Build completed successfully!"
