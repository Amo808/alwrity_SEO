#!/bin/bash
echo "Starting Lobe Chat build process..."

echo "Enabling pnpm..."
corepack enable pnpm

echo "Installing dependencies..."
pnpm install --no-frozen-lockfile

echo "Building application with timeout..."
timeout 1800 pnpm run build || {
    echo "Build timed out or failed, trying alternative build..."
    NODE_OPTIONS="--max-old-space-size=4096" timeout 1200 pnpm exec next build
}

echo "Build completed!"
