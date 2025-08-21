# PowerShell скрипт для запуска Lobe Chat локально
# Для запуска из PowerShell: ./start-local.ps1

Write-Host "🚀 Запуск Lobe Chat локально..." -ForegroundColor Green

# Проверяем доступность pnpm
if (!(Get-Command "pnpm" -ErrorAction SilentlyContinue)) {
    Write-Host "❌ pnpm не найден. Устанавливаем..." -ForegroundColor Red
    corepack enable
    corepack prepare pnpm@latest --activate
}

# Очищаем кэш для избежания проблем
Write-Host "🧹 Очищаем кэш..." -ForegroundColor Yellow
if (Test-Path ".next") {
    Remove-Item -Recurse -Force ".next"
}
if (Test-Path "node_modules\.cache") {
    Remove-Item -Recurse -Force "node_modules\.cache"
}

# Устанавливаем зависимости если нужно
if (!(Test-Path "node_modules")) {
    Write-Host "📦 Устанавливаем зависимости..." -ForegroundColor Yellow
    pnpm install
}

# Получаем локальный IP адрес
$localIP = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias "Wi-Fi*", "Ethernet*" | Where-Object {$_.IPAddress -like "192.168.*" -or $_.IPAddress -like "10.*"} | Select-Object -First 1).IPAddress

Write-Host "🌐 Сервер будет доступен по адресам:" -ForegroundColor Cyan
Write-Host "   - Локально: http://localhost:3010" -ForegroundColor White
Write-Host "   - Из сети: http://$localIP:3010" -ForegroundColor White

# Устанавливаем переменные окружения
$env:HOSTNAME = "0.0.0.0"
$env:PORT = "3010"

# Запускаем сервер разработки
Write-Host "🎯 Запускаем сервер..." -ForegroundColor Green
pnpm dev --hostname 0.0.0.0 --port 3010
