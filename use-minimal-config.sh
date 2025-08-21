#!/bin/bash
# Switch to minimal config for memory-constrained builds

echo "🔄 Switching to minimal config for low memory build..."

# Backup original config
if [ -f "next.config.ts" ] && [ ! -f "next.config.original.ts" ]; then
    cp next.config.ts next.config.original.ts
    echo "✅ Original config backed up"
fi

# Use minimal config
if [ -f "next.config.minimal.ts" ]; then
    cp next.config.minimal.ts next.config.ts
    echo "✅ Switched to minimal config"
else
    echo "❌ Minimal config not found"
fi
