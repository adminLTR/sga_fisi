# Script de Verificación Rápida de Seguridad
# SGA FISI - Verificación y Validación de Software

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  VERIFICACIÓN DE SEGURIDAD - SGA FISI" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Variables
$URL = "http://localhost:8000"
$CHECK_PASSED = 0
$CHECK_FAILED = 0

Write-Host "🔍 Verificando servidor en $URL..." -ForegroundColor Yellow
Write-Host ""

# Verificar si el servidor está corriendo
try {
    $response = Invoke-WebRequest -Uri $URL -Method Head -UseBasicParsing -ErrorAction Stop
    Write-Host "✅ Servidor está corriendo" -ForegroundColor Green
    $CHECK_PASSED++
} catch {
    Write-Host "❌ Servidor NO está corriendo. Ejecuta: python manage.py runserver" -ForegroundColor Red
    $CHECK_FAILED++
    Write-Host ""
    Write-Host "Presiona cualquier tecla para salir..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit
}

Write-Host ""
Write-Host "🛡️ Verificando Headers de Seguridad..." -ForegroundColor Yellow
Write-Host ""

# Verificar headers de seguridad
$headers = $response.Headers

# Content-Security-Policy
if ($headers.ContainsKey("Content-Security-Policy")) {
    Write-Host "✅ Content-Security-Policy: PRESENTE" -ForegroundColor Green
    $CHECK_PASSED++
} else {
    Write-Host "❌ Content-Security-Policy: FALTANTE" -ForegroundColor Red
    $CHECK_FAILED++
}

# X-Frame-Options
if ($headers.ContainsKey("X-Frame-Options")) {
    Write-Host "✅ X-Frame-Options: $($headers['X-Frame-Options'])" -ForegroundColor Green
    $CHECK_PASSED++
} else {
    Write-Host "❌ X-Frame-Options: FALTANTE" -ForegroundColor Red
    $CHECK_FAILED++
}

# X-Content-Type-Options
if ($headers.ContainsKey("X-Content-Type-Options")) {
    Write-Host "✅ X-Content-Type-Options: $($headers['X-Content-Type-Options'])" -ForegroundColor Green
    $CHECK_PASSED++
} else {
    Write-Host "❌ X-Content-Type-Options: FALTANTE" -ForegroundColor Red
    $CHECK_FAILED++
}

# X-XSS-Protection
if ($headers.ContainsKey("X-XSS-Protection")) {
    Write-Host "✅ X-XSS-Protection: $($headers['X-XSS-Protection'])" -ForegroundColor Green
    $CHECK_PASSED++
} else {
    Write-Host "❌ X-XSS-Protection: FALTANTE" -ForegroundColor Red
    $CHECK_FAILED++
}

# Referrer-Policy
if ($headers.ContainsKey("Referrer-Policy")) {
    Write-Host "✅ Referrer-Policy: $($headers['Referrer-Policy'])" -ForegroundColor Green
    $CHECK_PASSED++
} else {
    Write-Host "❌ Referrer-Policy: FALTANTE" -ForegroundColor Red
    $CHECK_FAILED++
}

# Permissions-Policy
if ($headers.ContainsKey("Permissions-Policy")) {
    Write-Host "✅ Permissions-Policy: PRESENTE" -ForegroundColor Green
    $CHECK_PASSED++
} else {
    Write-Host "❌ Permissions-Policy: FALTANTE" -ForegroundColor Red
    $CHECK_FAILED++
}

# Cross-Origin-Opener-Policy
if ($headers.ContainsKey("Cross-Origin-Opener-Policy")) {
    Write-Host "✅ Cross-Origin-Opener-Policy: $($headers['Cross-Origin-Opener-Policy'])" -ForegroundColor Green
    $CHECK_PASSED++
} else {
    Write-Host "❌ Cross-Origin-Opener-Policy: FALTANTE" -ForegroundColor Red
    $CHECK_FAILED++
}

# Cross-Origin-Resource-Policy
if ($headers.ContainsKey("Cross-Origin-Resource-Policy")) {
    Write-Host "✅ Cross-Origin-Resource-Policy: $($headers['Cross-Origin-Resource-Policy'])" -ForegroundColor Green
    $CHECK_PASSED++
} else {
    Write-Host "❌ Cross-Origin-Resource-Policy: FALTANTE" -ForegroundColor Red
    $CHECK_FAILED++
}

# Server Header
if ($headers.ContainsKey("Server")) {
    $serverValue = $headers['Server']
    if ($serverValue -eq "Servidor Web") {
        Write-Host "✅ Server Header: OCULTADO ($serverValue)" -ForegroundColor Green
        $CHECK_PASSED++
    } else {
        Write-Host "⚠️ Server Header: EXPUESTO ($serverValue)" -ForegroundColor Yellow
        $CHECK_FAILED++
    }
} else {
    Write-Host "✅ Server Header: NO PRESENTE (ideal)" -ForegroundColor Green
    $CHECK_PASSED++
}

Write-Host ""
Write-Host "📊 Resumen de Verificación" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "✅ Verificaciones exitosas: $CHECK_PASSED" -ForegroundColor Green
Write-Host "❌ Verificaciones fallidas: $CHECK_FAILED" -ForegroundColor Red

$TOTAL = $CHECK_PASSED + $CHECK_FAILED
$PERCENTAGE = [math]::Round(($CHECK_PASSED / $TOTAL) * 100, 2)

Write-Host ""
Write-Host "Puntuación de Seguridad: $PERCENTAGE%" -ForegroundColor $(if ($PERCENTAGE -ge 80) { "Green" } elseif ($PERCENTAGE -ge 60) { "Yellow" } else { "Red" })

if ($PERCENTAGE -eq 100) {
    Write-Host ""
    Write-Host "🎉 ¡EXCELENTE! Todas las verificaciones pasaron." -ForegroundColor Green
    Write-Host "El sistema está correctamente protegido." -ForegroundColor Green
} elseif ($PERCENTAGE -ge 80) {
    Write-Host ""
    Write-Host "✅ BUENO. La mayoría de las verificaciones pasaron." -ForegroundColor Yellow
    Write-Host "Revisa los elementos faltantes arriba." -ForegroundColor Yellow
} else {
    Write-Host ""
    Write-Host "❌ ATENCIÓN. Muchas verificaciones fallaron." -ForegroundColor Red
    Write-Host "Revisa la configuración en settings.py y middleware.py" -ForegroundColor Red
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "💡 Comandos útiles:" -ForegroundColor Yellow
Write-Host "   - Ver todos los headers: curl -I $URL" -ForegroundColor Gray
Write-Host "   - Django security check: python manage.py check --deploy" -ForegroundColor Gray
Write-Host "   - Ver logs: Get-Content .\logs\security.log -Tail 20" -ForegroundColor Gray
Write-Host ""
Write-Host "📚 Documentación completa en:" -ForegroundColor Yellow
Write-Host "   - INFORME_SEGURIDAD_VYV.md" -ForegroundColor Gray
Write-Host "   - GUIA_VERIFICACION_SEGURIDAD.md" -ForegroundColor Gray
Write-Host "   - README_SEGURIDAD.md" -ForegroundColor Gray
Write-Host ""

Write-Host "Presiona cualquier tecla para salir..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
