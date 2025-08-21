#!/bin/bash
echo "Starting Lobe Chat build process..."

echo "Enabling pnpm..."
corepack enable pnpm

echo "Installing dependencies..."
pnpm install --no-frozen-lockfile

echo "Building application..."
pnpm run build

echo "Build completed successfully!"
