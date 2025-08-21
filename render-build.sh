#!/bin/bash
# Render build script that properly handles pnpm

echo "🚀 Starting Lobe Chat build process..."

# Enable corepack and pnpm
echo "📦 Enabling pnpm..."
corepack enable pnpm

# Verify pnpm is available
pnpm --version

echo "📥 Installing dependencies..."
pnpm install --frozen-lockfile

echo "🔨 Building application..."
pnpm run build

echo "✅ Build completed successfully!"
