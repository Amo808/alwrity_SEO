#!/bin/bash
echo "Starting Lobe Chat..."

export PORT=${PORT:-10000}
echo "Using port: $PORT"

echo "Enabling pnpm..."
corepack enable pnpm

echo "Starting Next.js server..."
pnpm exec next start -p $PORT
