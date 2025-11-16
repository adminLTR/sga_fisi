# 🚀 Guía de Despliegue en Producción - SGA FISI

## 📋 Checklist Pre-Despliegue

Esta guía contiene las configuraciones críticas que DEBEN verificarse antes del despliegue en producción para resolver las alertas identificadas por OWASP ZAP.

---

## 🔒 Configuraciones de Seguridad Críticas

### 1. **Variables de Entorno en PythonAnywhere**

Asegúrate de configurar las siguientes variables de entorno en el archivo `.env` o en la configuración del servidor:

```bash
# En PythonAnywhere > Web > Virtualenv > Environment variables
DEBUG=False
SECRET_KEY=tu-clave-secreta-muy-larga-y-aleatoria-aqui
ALLOWED_HOSTS=lauranotfound.pythonanywhere.com,.pythonanywhere.com
DATABASE_URL=postgres://usuario:contraseña@host:puerto/database

# Importante: Usar valores seguros y únicos en producción
```

### 2. **Verificar settings.py en Producción**

**CRÍTICO**: El reporte ZAP muestra que CSP (288 instancias) y HSTS (325 instancias) no están aplicándose. Verificar:

```python
# ✅ DEBE estar en True en producción
DEBUG = False  # ❌ Si está en True, muchas vulnerabilidades se exponen

# ✅ Middleware personalizado debe estar activo
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'whitenoise.middleware.WhiteNoiseMiddleware',  # Para archivos estáticos
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'sga_fisi.middleware.SecurityHeadersMiddleware',  # ← Este DEBE estar presente
]

# ✅ HTTPS forzado
SECURE_SSL_REDIRECT = True  # Forzar HTTPS
SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')

# ✅ HSTS (Resuelve Alert 8 - 325 instancias)
SECURE_HSTS_SECONDS = 31536000  # 1 año
SECURE_HSTS_INCLUDE_SUBDOMAINS = True
SECURE_HSTS_PRELOAD = True

# ✅ Cookies seguras (Resuelve Alerts 4 y 5 - 283 instancias)
SESSION_COOKIE_SECURE = True
SESSION_COOKIE_HTTPONLY = True
CSRF_COOKIE_SECURE = True
CSRF_COOKIE_HTTPONLY = True
CSRF_COOKIE_SAMESITE = 'Strict'
CSRF_USE_SESSIONS = True  # Token CSRF en sesión, no en cookie
```

---

## 🔧 Comandos de Despliegue en PythonAnywhere

### Paso 1: Conectar por SSH o usar Bash console

```bash
cd ~/sga_fisi

# Activar entorno virtual
source env/bin/activate

# Actualizar código desde Git
git pull origin master
```

### Paso 2: Instalar/Actualizar dependencias

```bash
pip install -r requirements.txt

# Verificar que argon2-cffi esté instalado
pip show argon2-cffi
```

### Paso 3: Aplicar migraciones

```bash
python manage.py migrate

# Colectar archivos estáticos
python manage.py collectstatic --noinput
```

### Paso 4: Verificar configuración

```bash
# Verificar que DEBUG=False
python manage.py shell
>>> from django.conf import settings
>>> print(f"DEBUG={settings.DEBUG}")  # Debe mostrar False
>>> print(f"ALLOWED_HOSTS={settings.ALLOWED_HOSTS}")
>>> print(f"MIDDLEWARE={settings.MIDDLEWARE}")
>>> exit()
```

### Paso 5: Recargar aplicación web

En el dashboard de PythonAnywhere:
1. Ir a **Web** tab
2. Click en **"Reload lauranotfound.pythonanywhere.com"**
3. Verificar que no haya errores en el log

---

## 🧪 Verificación Post-Despliegue

### 1. Verificar Headers HTTP

Ejecutar desde tu máquina local:

```powershell
# Verificar HSTS (Alert 8)
curl -I https://lauranotfound.pythonanywhere.com/

# Debe mostrar:
# Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
# Content-Security-Policy: default-src 'self'; ...
# X-Frame-Options: DENY
# X-Content-Type-Options: nosniff
# Access-Control-Allow-Origin: lauranotfound.pythonanywhere.com
```

### 2. Verificar Cookies

```powershell
# Verificar flags de cookies (Alerts 4 y 5)
curl -I https://lauranotfound.pythonanywhere.com/admin/

# Set-Cookie debe incluir: Secure; HttpOnly; SameSite=Strict
```

### 3. Verificar Páginas de Error

```powershell
# Verificar error 404 (Alert 6)
curl https://lauranotfound.pythonanywhere.com/pagina-inexistente

# Debe mostrar página personalizada sin información sensible
```

### 4. Verificar CSRF Protection

```powershell
# Verificar que formularios incluyan CSRF token (Alert 1)
curl https://lauranotfound.pythonanywhere.com/admin/ | Select-String "csrfmiddlewaretoken"

# Debe encontrar el token CSRF en el HTML
```

---

## 🚨 Alertas Resueltas vs Pendientes

### ✅ **Alertas RESUELTAS con este despliegue:**

| # | Alerta | Riesgo | Instancias | Solución Implementada |
|---|--------|--------|------------|----------------------|
| 2 | CSP no configurada | MEDIO | 288 | SecurityHeadersMiddleware activo |
| 3 | Cross-Domain CORS | MEDIO | 36 | Headers CORS configurados |
| 4 | Cookie sin HttpOnly | LOW | 141 | CSRF_COOKIE_HTTPONLY=True |
| 5 | Cookie sin Secure | LOW | 142 | CSRF_COOKIE_SECURE=True |
| 6 | Error disclosure | LOW | 3 | Templates 404.html y 500.html |
| 8 | HSTS no establecido | LOW | 325 | SECURE_HSTS_SECONDS=31536000 |

**Total reducción esperada: ~935 instancias (93% de alerts MEDIUM/LOW)**

### ⚠️ **Alertas PENDIENTES (requieren investigación adicional):**

| # | Alerta | Riesgo | Instancias | Acción Requerida |
|---|--------|--------|------------|------------------|
| 1 | CSRF tokens ausentes | MEDIO | 3 | Verificar dpaste.com forms - pueden ser del admin de Django |
| 7 | Private IP disclosure | LOW | 3 | IP 10.0.5.32 - probablemente infraestructura PythonAnywhere |
| 9-14 | Informational | INFO | 450 | Revisar false positives (jQuery, Django admin) |

---

## 📊 Comandos de Verificación Automatizada

Ejecutar el script de PowerShell actualizado:

```powershell
cd D:\PROGRAMACION\PROYECTS\sga_fisi
.\verificar_seguridad.ps1
```

---

## 🔍 Debugging si Headers no Aparecen

Si después del despliegue los headers HSTS/CSP aún no aparecen:

### Opción 1: Verificar que middleware se está ejecutando

Agregar temporalmente al middleware.py:

```python
def __call__(self, request):
    response = self.get_response(request)
    
    # DEBUG: Imprimir para verificar
    import sys
    print("SecurityHeadersMiddleware ejecutándose", file=sys.stderr)
    
    # ... resto del código
```

Revisar logs en PythonAnywhere > Web > Error log

### Opción 2: PythonAnywhere puede estar sobreescribiendo headers

Contactar soporte de PythonAnywhere o verificar si tienen configuraciones de servidor que sobreescriban headers.

### Opción 3: Usar django-csp y django-security paquetes oficiales

```bash
pip install django-csp django-security
```

Configurar en settings.py:

```python
INSTALLED_APPS = [
    ...
    'csp',
    'security',
]

# CSP usando django-csp
CSP_DEFAULT_SRC = ("'self'",)
CSP_SCRIPT_SRC = ("'self'", "'unsafe-inline'")
# ... (resto de directivas)
```

---

## 📞 Soporte y Escalación

Si después de implementar todas las correcciones las alertas persisten:

1. **Verificar logs de PythonAnywhere**: Web > Error log y Server log
2. **Revisar configuración WSGI**: Archivo wsgi.py debe cargar settings correctamente
3. **Contactar soporte PythonAnywhere**: Pueden tener restricciones en headers HTTP
4. **Ejecutar nuevo scan ZAP**: Para confirmar reducción de alertas

---

## 🎯 Resultado Esperado

Después de desplegar correctamente:

- ✅ **MEDIUM alerts**: De 3 tipos (327 instancias) a 1 tipo (3 instancias) → **99% reducción**
- ✅ **LOW alerts**: De 5 tipos (614 instancias) a 1 tipo (3 instancias) → **99.5% reducción**
- ✅ **Score ZAP**: Mejora significativa en rating de seguridad

**Total**: De 1,009 instancias a ~456 instancias (reducción del 55%), concentradas principalmente en alertas INFORMATIONAL (false positives esperados).

---

## 📝 Notas Finales

- **DEBUG=False es CRÍTICO**: La mayoría de vulnerabilidades se exponen con DEBUG=True
- **Verificar que middleware esté en la lista**: Es la razón más común de headers faltantes
- **HTTPS debe estar activo**: PythonAnywhere lo provee automáticamente
- **Cookies solo funcionan con HTTPS**: Si HTTPS no está activo, los flags Secure no funcionarán

---

**Fecha de creación**: Noviembre 2025  
**Proyecto**: SGA FISI - Sistema de Gestión Académica  
**Autor**: Equipo de Desarrollo  
**Curso**: Verificación y Validación de Software
