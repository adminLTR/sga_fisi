# 🐳 Guía de Despliegue con Docker - Sistema SGA FISI

Este documento explica cómo levantar el proyecto **Sistema de Gestión Administrativa (SGA)** de la Facultad de Ingeniería de Sistemas e Informática usando Docker.

## 📋 Requisitos Previos

- Docker Desktop instalado ([Descargar aquí](https://www.docker.com/products/docker-desktop))
- Docker Compose (incluido en Docker Desktop)
- Git (para clonar el repositorio)

## 🚀 Pasos para Levantar el Proyecto

### 1. Preparar el Entorno

Primero, crea tu archivo de variables de entorno:

```powershell
# Copiar el archivo de ejemplo
Copy-Item .env.example .env
```

Edita el archivo `.env` con tus configuraciones (opcional, los valores por defecto funcionan):

```env
# Configuración de Django
SECRET_KEY=django-insecure-change-this-in-production-with-a-secure-random-key
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1,0.0.0.0,*
CSRF_TRUSTED_ORIGINS=http://localhost:8000,http://127.0.0.1:8000

# Configuración de Base de Datos PostgreSQL
DB_NAME=sga_fisi_db
DB_USER=sga_user
DB_PASS=sga_password
DB_HOST=db
DB_PORT=5432
```

### 2. Construir y Levantar los Contenedores

```powershell
# Construir las imágenes y levantar los servicios
docker-compose up --build
```

O en modo detached (segundo plano):

```powershell
docker-compose up --build -d
```

### 3. Verificar que Todo Está Funcionando

El script `entrypoint.sh` ejecutará automáticamente:

1. ✅ Espera a que PostgreSQL esté listo
2. ✅ Crea las migraciones de Django
3. ✅ Ejecuta las migraciones en la base de datos
4. ✅ Recolecta los archivos estáticos
5. ✅ Ejecuta los seeders con datos iniciales (usando upsert)
6. ✅ Crea un superusuario admin (usuario: `admin`, contraseña: `admin123`)
7. ✅ Inicia el servidor Gunicorn

### 4. Acceder al Sistema

Una vez que los contenedores estén corriendo:

- **Aplicación Web**: http://localhost:8000
- **Panel de Administración**: http://localhost:8000/admin

**Credenciales del Superusuario:**
- Usuario: `admin`
- Contraseña: `admin123`

## 📊 Datos Iniciales (Seeders)

El sistema carga automáticamente datos de ejemplo:

- **Facultades**: FISI, FIM, FIEE, FIGMM, FIQ, FC
- **Áreas Académicas**: Informática, Matemáticas, Física, Humanidades, Ingeniería
- **Escuelas**: Ingeniería de Sistemas, Ingeniería de Software, Ciencia de la Computación
- **Días de la semana**: Lunes a Sábado
- **Semestres**: 2024-I, 2024-II, 2025-I (activo), 2025-II
- **Locales**: Pabellón FISI, FIM, FIEE, Laboratorios Centrales
- **Aulas**: A-101, A-102, A-201, A-202, A-301, LAB-1, LAB-2, LAB-3
- **Tipos de Curso**: Obligatorio, Electivo, Humanidades, Ciencias Básicas
- **Planes de Estudio**: 2018-IS, 2020-IS, 2020-SW, 2020-CC
- **Cursos de ejemplo**: Introducción a la Informática, Matemática I y II, Base de Datos I, etc.
- **Tipos de Dictado**: Teoría, Práctica, Laboratorio, Seminario

## 🔧 Comandos Útiles

### Ver logs en tiempo real:
```powershell
docker-compose logs -f
```

### Ver logs solo del servicio web:
```powershell
docker-compose logs -f web
```

### Detener los contenedores:
```powershell
docker-compose down
```

### Detener y eliminar volúmenes (¡CUIDADO! Esto borra la base de datos):
```powershell
docker-compose down -v
```

### Reiniciar solo el servicio web:
```powershell
docker-compose restart web
```

### Ejecutar comandos Django dentro del contenedor:
```powershell
# Crear un nuevo superusuario
docker-compose exec web python manage.py createsuperuser

# Ejecutar seeders manualmente
docker-compose exec web python manage.py seed_data

# Crear migraciones
docker-compose exec web python manage.py makemigrations

# Ejecutar migraciones
docker-compose exec web python manage.py migrate

# Entrar al shell de Django
docker-compose exec web python manage.py shell
```

### Acceder a la base de datos PostgreSQL:
```powershell
docker-compose exec db psql -U sga_user -d sga_fisi_db
```

### Acceder al contenedor:
```powershell
# Acceder al contenedor web
docker-compose exec web bash

# Acceder al contenedor de la base de datos
docker-compose exec db bash
```

## 🛠️ Comandos de Desarrollo

### Ejecutar migraciones específicas de una app:
```powershell
docker-compose exec web python manage.py migrate general
docker-compose exec web python manage.py migrate escuela
docker-compose exec web python manage.py migrate administrativo
docker-compose exec web python manage.py migrate vicerrectorado
```

### Revertir migraciones:
```powershell
docker-compose exec web python manage.py migrate general zero
```

### Ver el estado de las migraciones:
```powershell
docker-compose exec web python manage.py showmigrations
```

## 🔄 Actualizar el Proyecto

Si haces cambios en el código:

```powershell
# Reconstruir las imágenes
docker-compose up --build

# O si los contenedores están corriendo, solo reinicia
docker-compose restart web
```

Si haces cambios en los modelos:

```powershell
# Crear y ejecutar migraciones
docker-compose exec web python manage.py makemigrations
docker-compose exec web python manage.py migrate
```

## 📦 Estructura de Servicios Docker

El proyecto usa 2 servicios:

1. **db**: PostgreSQL 15 (Base de datos)
   - Puerto: 5432
   - Volumen persistente: `postgres_data`

2. **web**: Django + Gunicorn (Aplicación)
   - Puerto: 8000
   - Depende de `db`
   - Ejecuta migraciones y seeders automáticamente al iniciar

## 🐛 Solución de Problemas

### El contenedor web no inicia:
```powershell
# Ver los logs
docker-compose logs web

# Verificar que PostgreSQL esté corriendo
docker-compose ps
```

### Error de conexión a la base de datos:
```powershell
# Verificar que el servicio db esté saludable
docker-compose ps

# Reiniciar los servicios
docker-compose restart
```

### Los cambios en el código no se reflejan:
```powershell
# Reconstruir la imagen
docker-compose up --build
```

### Resetear todo (base de datos incluida):
```powershell
# CUIDADO: Esto elimina todos los datos
docker-compose down -v
docker-compose up --build
```

## 📝 Notas Importantes

- Los **seeders usan upsert** (`update_or_create`), por lo que puedes ejecutarlos múltiples veces sin duplicar datos
- El **superusuario admin** se crea automáticamente en cada inicio si no existe
- Los **archivos media** (imágenes de aulas) se guardan en el volumen `media_volume`
- Los **archivos estáticos** se recolectan automáticamente en cada inicio
- El **puerto 8000** debe estar libre en tu máquina

## 🔐 Seguridad

Para producción, recuerda:

1. Cambiar el `SECRET_KEY` en el archivo `.env`
2. Establecer `DEBUG=False`
3. Configurar `ALLOWED_HOSTS` con tu dominio
4. Cambiar la contraseña del superusuario
5. Usar contraseñas seguras para PostgreSQL

## 📚 Recursos Adicionales

- [Documentación de Django](https://docs.djangoproject.com/)
- [Documentación de Docker](https://docs.docker.com/)
- [Documentación de PostgreSQL](https://www.postgresql.org/docs/)

---

**¡Listo!** Tu sistema SGA FISI debería estar funcionando en http://localhost:8000 🎉
