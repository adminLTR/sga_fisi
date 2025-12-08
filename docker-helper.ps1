# Script de ayuda para Docker - SGA FISI
# Uso: .\docker-helper.ps1 [comando]

param(
    [Parameter(Position=0)]
    [string]$Command = "help"
)

function Show-Help {
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host "   Sistema de Gestión Administrativa - FISI      " -ForegroundColor Cyan
    Write-Host "   Script de Ayuda para Docker                   " -ForegroundColor Cyan
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "USO: .\docker-helper.ps1 [comando]" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "COMANDOS DISPONIBLES:" -ForegroundColor Green
    Write-Host ""
    Write-Host "  start         " -NoNewline -ForegroundColor Yellow
    Write-Host "- Construir y levantar los contenedores"
    Write-Host "  stop          " -NoNewline -ForegroundColor Yellow
    Write-Host "- Detener los contenedores"
    Write-Host "  restart       " -NoNewline -ForegroundColor Yellow
    Write-Host "- Reiniciar los contenedores"
    Write-Host "  logs          " -NoNewline -ForegroundColor Yellow
    Write-Host "- Ver logs en tiempo real"
    Write-Host "  shell         " -NoNewline -ForegroundColor Yellow
    Write-Host "- Acceder al shell del contenedor web"
    Write-Host "  db            " -NoNewline -ForegroundColor Yellow
    Write-Host "- Acceder a PostgreSQL"
    Write-Host "  migrate       " -NoNewline -ForegroundColor Yellow
    Write-Host "- Ejecutar migraciones"
    Write-Host "  seed          " -NoNewline -ForegroundColor Yellow
    Write-Host "- Ejecutar seeders"
    Write-Host "  clean         " -NoNewline -ForegroundColor Yellow
    Write-Host "- Limpiar todo (¡CUIDADO! Borra la BD)"
    Write-Host "  status        " -NoNewline -ForegroundColor Yellow
    Write-Host "- Ver estado de los contenedores"
    Write-Host "  help          " -NoNewline -ForegroundColor Yellow
    Write-Host "- Mostrar esta ayuda"
    Write-Host ""
    Write-Host "EJEMPLOS:" -ForegroundColor Green
    Write-Host "  .\docker-helper.ps1 start" -ForegroundColor Cyan
    Write-Host "  .\docker-helper.ps1 logs" -ForegroundColor Cyan
    Write-Host "  .\docker-helper.ps1 shell" -ForegroundColor Cyan
    Write-Host ""
}

switch ($Command.ToLower()) {
    "start" {
        Write-Host "🚀 Construyendo y levantando los contenedores..." -ForegroundColor Green
        docker-compose up --build
    }
    "stop" {
        Write-Host "🛑 Deteniendo los contenedores..." -ForegroundColor Yellow
        docker-compose down
    }
    "restart" {
        Write-Host "🔄 Reiniciando los contenedores..." -ForegroundColor Yellow
        docker-compose restart
    }
    "logs" {
        Write-Host "📋 Mostrando logs en tiempo real (Ctrl+C para salir)..." -ForegroundColor Cyan
        docker-compose logs -f
    }
    "shell" {
        Write-Host "🐚 Accediendo al shell del contenedor web..." -ForegroundColor Cyan
        docker-compose exec web bash
    }
    "db" {
        Write-Host "🗄️ Accediendo a PostgreSQL..." -ForegroundColor Cyan
        Write-Host "Contraseña: sga_password" -ForegroundColor Yellow
        docker-compose exec db psql -U sga_user -d sga_fisi_db
    }
    "migrate" {
        Write-Host "🔄 Ejecutando migraciones..." -ForegroundColor Green
        docker-compose exec web python manage.py makemigrations
        docker-compose exec web python manage.py migrate
    }
    "seed" {
        Write-Host "🌱 Ejecutando seeders..." -ForegroundColor Green
        docker-compose exec web python manage.py seed_data
    }
    "clean" {
        Write-Host "⚠️  ADVERTENCIA: Esto eliminará todos los contenedores y volúmenes (incluida la base de datos)" -ForegroundColor Red
        $confirmation = Read-Host "¿Estás seguro? Escribe 'SI' para confirmar"
        if ($confirmation -eq "SI") {
            Write-Host "🧹 Limpiando todo..." -ForegroundColor Red
            docker-compose down -v
            Write-Host "✅ Limpieza completada" -ForegroundColor Green
        } else {
            Write-Host "❌ Operación cancelada" -ForegroundColor Yellow
        }
    }
    "status" {
        Write-Host "📊 Estado de los contenedores:" -ForegroundColor Cyan
        docker-compose ps
    }
    "help" {
        Show-Help
    }
    default {
        Write-Host "❌ Comando no reconocido: $Command" -ForegroundColor Red
        Write-Host ""
        Show-Help
    }
}
