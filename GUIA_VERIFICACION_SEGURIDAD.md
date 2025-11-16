# Guía de Verificación de Correcciones de Seguridad

## 1. Verificar Headers de Seguridad con curl

```powershell
# Verificar headers en página principal
curl -I http://localhost:8000/

# Verificar headers en página de admin
curl -I http://localhost:8000/admin/

# Verificar headers en página de login
curl -I http://localhost:8000/login/
```

**Headers esperados:**
- `Content-Security-Policy: default-src 'self'; ...`
- `X-Frame-Options: DENY`
- `X-Content-Type-Options: nosniff`
- `X-XSS-Protection: 1; mode=block`
- `Referrer-Policy: same-origin`
- `Permissions-Policy: geolocation=(), ...`
- `Cross-Origin-Opener-Policy: same-origin`
- `Cross-Origin-Resource-Policy: same-origin`
- `Strict-Transport-Security: max-age=31536000` (solo en producción con HTTPS)
- `Server: Servidor Web` (sin información de versión)

---

## 2. Verificar Configuración de Django

```powershell
# Activar entorno virtual
.\env\Scripts\activate

# Ejecutar verificación de seguridad de Django
python manage.py check --deploy
```

**Resultado esperado:** Ningún error crítico de seguridad

---

## 3. Verificar Cookies en Navegador

1. Abrir el navegador (Chrome/Firefox)
2. Ir a `http://localhost:8000/admin/`
3. Abrir DevTools (F12)
4. Ir a la pestaña **Application** (Chrome) o **Storage** (Firefox)
5. Seleccionar **Cookies** > `http://localhost:8000`

**Verificar que las cookies tengan:**
- ✅ `sessionid`: Flags `HttpOnly`, `Secure` (si HTTPS), `SameSite=Lax`
- ✅ `csrftoken`: Flags `HttpOnly`, `Secure` (si HTTPS), `SameSite=Lax`

---

## 4. Re-escanear con OWASP ZAP

### Opción A: Usar ZAP Desktop
1. Abrir OWASP ZAP
2. Ir a **Quick Start** > **Automated Scan**
3. Ingresar URL: `http://localhost:8000`
4. Click en **Attack**
5. Revisar resultados en la pestaña **Alerts**

### Opción B: Usar ZAP CLI (si está instalado)
```powershell
# Escaneo rápido
zap-cli quick-scan --self-contained http://localhost:8000/

# Escaneo completo con spider
zap-cli start
zap-cli spider http://localhost:8000/
zap-cli active-scan http://localhost:8000/
zap-cli alerts
```

**Resultado esperado:** 
- ❌ 0 alertas de severidad ALTA
- ❌ 0 alertas de severidad MEDIA relacionadas con headers
- ✅ Mejora significativa en la puntuación de seguridad

---

## 5. Verificar Logging de Seguridad

```powershell
# Verificar que la carpeta de logs existe
Test-Path .\logs

# Iniciar el servidor
python manage.py runserver

# Generar un error de seguridad intencional (ejemplo: CSRF)
# Luego verificar el log
Get-Content .\logs\security.log -Tail 20
```

---

## 6. Probar Protección Anti-Clickjacking

Crear un archivo HTML temporal `test_clickjacking.html`:

```html
<!DOCTYPE html>
<html>
<head>
    <title>Test Clickjacking</title>
</head>
<body>
    <h1>Test de Protección Anti-Clickjacking</h1>
    <p>Si el iframe no se muestra, la protección está funcionando ✅</p>
    <iframe src="http://localhost:8000/admin/" width="800" height="600"></iframe>
</body>
</html>
```

Abrir este archivo en el navegador. **Resultado esperado:** El iframe NO debe mostrarse (bloqueado por X-Frame-Options).

---

## 7. Probar Content Security Policy

Abrir la consola del navegador (F12 > Console) al cargar la página.

**Resultado esperado:** 
- ❌ NO deben aparecer errores de CSP si todos los recursos son del mismo origen
- ✅ Si intentas inyectar un script externo no autorizado, debe ser bloqueado

Prueba manual:
```javascript
// En la consola del navegador, intentar cargar un script externo
var script = document.createElement('script');
script.src = 'https://evil.com/malicious.js';
document.head.appendChild(script);
```

**Resultado esperado:** Error de CSP bloqueando la carga.

---

## 8. Verificar Configuración de Producción

Antes de desplegar en producción, verificar que el archivo `.env` tenga:

```env
DEBUG=False
SECRET_KEY=<clave-aleatoria-segura-de-64-caracteres>
ALLOWED_HOSTS=tu-dominio.com,www.tu-dominio.com
CSRF_TRUSTED_ORIGINS=https://tu-dominio.com,https://www.tu-dominio.com
DB_NAME=nombre_base_datos
DB_USER=usuario_db
DB_PASS=contraseña_segura
DB_HOST=localhost
DB_PORT=5432
ADMIN_EMAIL=admin@fisi.edu.pe
```

---

## 9. Checklist Final de Verificación

- [ ] Headers de seguridad presentes en todas las respuestas HTTP
- [ ] Cookies con flags Secure, HttpOnly, SameSite
- [ ] X-Frame-Options bloqueando iframes
- [ ] CSP configurado y sin errores en consola
- [ ] HSTS configurado (en producción con HTTPS)
- [ ] `python manage.py check --deploy` sin errores críticos
- [ ] OWASP ZAP sin alertas de severidad ALTA o MEDIA
- [ ] Logging de seguridad funcionando
- [ ] DEBUG=False en producción
- [ ] SECRET_KEY configurada y segura
- [ ] ALLOWED_HOSTS y CSRF_TRUSTED_ORIGINS configurados
- [ ] Servidor no revela información de versión

---

## 10. Comparación de Resultados

### Antes de las Correcciones (Situación Inicial)
Ejecutar:
```powershell
curl -I http://localhost:8000/ | Select-String "Content-Security-Policy|X-Frame-Options|X-Content-Type-Options|Strict-Transport-Security"
```
**Resultado esperado (ANTES):** Ninguno de estos headers presente

### Después de las Correcciones (Situación Final)
Ejecutar el mismo comando:
```powershell
curl -I http://localhost:8000/ | Select-String "Content-Security-Policy|X-Frame-Options|X-Content-Type-Options|Strict-Transport-Security"
```
**Resultado esperado (DESPUÉS):** Todos los headers presentes ✅

---

## 11. Capturas de Pantalla Recomendadas para el Informe

1. **ZAP Scan Inicial:** Captura de pantalla mostrando las vulnerabilidades encontradas
2. **ZAP Scan Final:** Captura mostrando 0 vulnerabilidades críticas/medias
3. **Headers HTTP (Antes):** Usando DevTools o curl
4. **Headers HTTP (Después):** Mostrando todos los headers de seguridad
5. **Cookies Seguras:** DevTools mostrando flags Secure, HttpOnly, SameSite
6. **CSP en Consola:** Sin errores de violación de CSP
7. **Django Check Deploy:** Salida del comando sin errores

---

## 12. Herramientas Online Adicionales

Después de desplegar en producción, verificar con:

1. **Security Headers:** https://securityheaders.com/
   - Ingresar tu URL
   - Debe obtener calificación A o superior

2. **Mozilla Observatory:** https://observatory.mozilla.org/
   - Escaneo completo de seguridad
   - Debe obtener calificación A+ o A

3. **SSL Labs:** https://www.ssllabs.com/ssltest/
   - Verifica configuración SSL/TLS
   - Debe obtener calificación A o superior

---

## Notas Importantes

- Las verificaciones se deben hacer tanto en **desarrollo** (localhost) como en **producción**
- Algunos headers (como HSTS) solo funcionan correctamente con HTTPS
- El middleware personalizado debe estar activo para que todos los headers se apliquen
- Mantener logs de todas las verificaciones para el informe final

---

**Última actualización:** 16 de Noviembre de 2025
