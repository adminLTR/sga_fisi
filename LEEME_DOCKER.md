# 🎯 INSTRUCCIONES FINALES - Sistema SGA FISI con Docker

## ✅ ¡Todo está listo! Archivos creados:

- ✅ `Dockerfile` - Imagen de Docker para Django
- ✅ `docker-compose.yml` - Orquestación de servicios (PostgreSQL + Django)
- ✅ `entrypoint.sh` - Script que ejecuta migraciones y seeders automáticamente
- ✅ `.env` - Variables de entorno configuradas
- ✅ `.dockerignore` - Archivos a ignorar en la imagen
- ✅ `general/management/commands/seed_data.py` - Seeders con upsert
- ✅ `docker-helper.ps1` - Script de ayuda para comandos comunes
- ✅ Documentación completa

## 🚀 PASO 1: Inicia Docker Desktop

**IMPORTANTE:** Antes de continuar, asegúrate de que Docker Desktop esté corriendo:

1. Abre Docker Desktop desde el menú de inicio
2. Espera a que el ícono de Docker en la bandeja del sistema deje de parpadear
3. Verifica que diga "Docker Desktop is running"

## 🐳 PASO 2: Levanta el proyecto

Abre PowerShell en la carpeta del proyecto y ejecuta:

```powershell
# Opción 1: Con el script helper (recomendado)
.\docker-helper.ps1 start

# Opción 2: Comando directo
docker-compose up --build
```

**Nota:** La primera vez tomará varios minutos porque tiene que:
- Descargar la imagen de Python
- Descargar la imagen de PostgreSQL
- Instalar todas las dependencias
- Ejecutar migraciones
- Cargar datos de ejemplo

## 🌐 PASO 3: Accede al sistema

Una vez que veas el mensaje "Inicialización completada!", accede a:

- **Aplicación**: http://localhost:8000
- **Panel Admin**: http://localhost:8000/admin
  - Usuario: `admin`
  - Contraseña: `admin123`

## 📊 ¿Qué datos se cargan automáticamente?

El sistema incluye seeders que cargan datos de ejemplo **usando upsert** (update_or_create):

### Datos Generales:
- 6 Facultades (FISI, FIM, FIEE, FIGMM, FIQ, FC)
- 5 Áreas Académicas (Informática, Matemáticas, Física, Humanidades, Ingeniería)
- 3 Escuelas (Ingeniería de Sistemas, Software, Ciencia de la Computación)
- 6 Días de la semana (Lunes a Sábado)

### Datos Administrativos:
- 4 Locales (Pabellones FISI, FIM, FIEE, Laboratorios)
- 8 Aulas (A-101 a A-301, LAB-1 a LAB-3)
- 4 Semestres (2024-I, 2024-II, 2025-I activo, 2025-II)

### Datos Académicos:
- 4 Tipos de Curso (Obligatorio, Electivo, Humanidades, Ciencias Básicas)
- 4 Planes de Estudio (2018-IS, 2020-IS, 2020-SW, 2020-CC)
- 7 Cursos de ejemplo (Introducción a Informática, Matemáticas, Base de Datos, etc.)
- 4 Tipos de Dictado (Teoría, Práctica, Laboratorio, Seminario)
- Horas de dictado configuradas para los cursos

## 🛠️ Comandos útiles

### Ver logs en tiempo real:
```powershell
docker-compose logs -f web
```

### Detener el proyecto:
```powershell
docker-compose down
```

### Reiniciar el proyecto:
```powershell
docker-compose restart
```

### Ejecutar seeders nuevamente:
```powershell
docker-compose exec web python manage.py seed_data
```

### Acceder al shell de Django:
```powershell
docker-compose exec web python manage.py shell
```

### Acceder a PostgreSQL:
```powershell
docker-compose exec db psql -U sga_user -d sga_fisi_db
```

### Ver estado de los contenedores:
```powershell
docker-compose ps
```

## 🔄 Características importantes de los Seeders

Los seeders están implementados con **upsert** (update_or_create), lo que significa:

✅ Puedes ejecutarlos múltiples veces sin duplicar datos  
✅ Actualizan registros existentes si ya existen  
✅ Crean nuevos registros si no existen  
✅ Son seguros para entornos de desarrollo y producción  

## 🔧 Si algo sale mal

### El contenedor no inicia:
```powershell
# Ver los logs completos
docker-compose logs web

# Reconstruir desde cero
docker-compose down -v
docker-compose up --build
```

### Error de conexión a la base de datos:
```powershell
# Verificar que PostgreSQL esté saludable
docker-compose ps

# Reiniciar todo
docker-compose restart
```

### Cambios en el código no se reflejan:
```powershell
# Reconstruir la imagen
docker-compose up --build
```

### Resetear todo (¡CUIDADO! Borra la base de datos):
```powershell
docker-compose down -v
docker-compose up --build
```

## 📚 Documentación adicional

- **DOCKER_QUICKSTART.md** - Inicio rápido en 3 pasos
- **DOCKER_README.md** - Documentación completa con todos los detalles
- **docker-helper.ps1** - Script con comandos útiles (ejecuta `.\docker-helper.ps1 help`)

## 🎓 Uso del Script Helper

El script `docker-helper.ps1` facilita el uso del proyecto:

```powershell
# Ver ayuda
.\docker-helper.ps1 help

# Iniciar el proyecto
.\docker-helper.ps1 start

# Ver logs
.\docker-helper.ps1 logs

# Acceder al shell
.\docker-helper.ps1 shell

# Acceder a la base de datos
.\docker-helper.ps1 db

# Ejecutar migraciones
.\docker-helper.ps1 migrate

# Ejecutar seeders
.\docker-helper.ps1 seed

# Ver estado
.\docker-helper.ps1 status

# Detener
.\docker-helper.ps1 stop

# Limpiar todo
.\docker-helper.ps1 clean
```

## 🔐 Seguridad (Para producción)

Si vas a usar esto en producción, cambia:

1. `SECRET_KEY` en `.env`
2. `DEBUG=False` en `.env`
3. Configura `ALLOWED_HOSTS` con tu dominio
4. Cambia la contraseña del admin
5. Usa contraseñas seguras para PostgreSQL

## 🎉 ¡Listo!

Tu proyecto Django con PostgreSQL está completamente dockerizado y listo para usar.

**Características implementadas:**
- ✅ Docker con PostgreSQL 15
- ✅ Django con todas las dependencias
- ✅ Migraciones automáticas al iniciar
- ✅ Seeders con upsert para todos los modelos
- ✅ Superusuario creado automáticamente
- ✅ Archivos estáticos configurados
- ✅ Gunicorn como servidor WSGI
- ✅ Volúmenes persistentes para datos
- ✅ Health checks para la base de datos
- ✅ Scripts de ayuda incluidos

---

**¿Necesitas ayuda?** Revisa los archivos de documentación o ejecuta `.\docker-helper.ps1 help`
