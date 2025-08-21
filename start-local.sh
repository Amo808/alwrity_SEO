#!/bin/bash
# Bash скрипт для запуска Lobe Chat локально
# Для запуска из Git Bash: ./start-local.sh

set -e

echo "🚀 Запуск Lobe Chat локально..."

# Проверяем доступность pnpm
if ! command -v pnpm &> /dev/null; then
    echo "❌ pnpm не найден. Устанавливаем..."
    corepack enable
    corepack prepare pnpm@latest --activate
fi

# Очищаем кэш для избежания проблем
echo "🧹 Очищаем кэш..."
rm -rf .next
rm -rf node_modules/.cache

# Устанавливаем зависимости если нужно
if [ ! -d "node_modules" ]; then
    echo "📦 Устанавливаем зависимости..."
    pnpm install
fi

# Получаем локальный IP адрес (Windows)
LOCAL_IP=$(ipconfig | grep -A 4 "Ethernet adapter" | grep "IPv4" | head -1 | cut -d ":" -f 2 | tr -d " " || echo "192.168.1.x")

echo "🌐 Сервер будет доступен по адресам:"
echo "   - Локально: http://localhost:3010"
echo "   - Из сети: http://$LOCAL_IP:3010"

# Устанавливаем переменные окружения
export HOSTNAME="0.0.0.0"
export PORT="3010"

# Запускаем сервер разработки
echo "🎯 Запускаем сервер..."
pnpm dev --hostname 0.0.0.0 --port 3010
