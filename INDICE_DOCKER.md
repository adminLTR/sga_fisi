# 📚 Índice de Documentación Docker - SGA FISI

## 🚀 Inicio Rápido

Si es tu primera vez, empieza por aquí:

1. **[LEEME_DOCKER.md](LEEME_DOCKER.md)** ⭐ **EMPIEZA AQUÍ**
   - Instrucciones paso a paso
   - Todo lo que necesitas saber
   - Troubleshooting incluido

2. **[DOCKER_QUICKSTART.md](DOCKER_QUICKSTART.md)**
   - Inicio rápido en 3 pasos
   - Para usuarios experimentados

## 📖 Documentación Detallada

### Guías de Usuario

- **[DOCKER_README.md](DOCKER_README.md)**
  - Documentación completa
  - Todos los comandos disponibles
  - Ejemplos de uso
  - FAQ y solución de problemas

- **[ARQUITECTURA_DOCKER.md](ARQUITECTURA_DOCKER.md)**
  - Diagramas de arquitectura
  - Flujo de datos
  - Relaciones entre modelos
  - Estructura técnica

### Archivos de Configuración

- **[docker-compose.yml](docker-compose.yml)**
  - Configuración de servicios
  - PostgreSQL + Django
  - Volúmenes y redes

- **[Dockerfile](Dockerfile)**
  - Imagen de Docker
  - Dependencias y configuración
  - Python 3.11 + Django

- **[.env](.env)** / **[.env.example](.env.example)**
  - Variables de entorno
  - Configuración de base de datos
  - Secrets de Django

- **[entrypoint.sh](entrypoint.sh)**
  - Script de inicialización
  - Ejecuta migraciones
  - Carga seeders
  - Crea superusuario

### Scripts de Ayuda

- **[docker-helper.ps1](docker-helper.ps1)**
  - Script de PowerShell
  - Comandos simplificados
  - Ejecuta: `.\docker-helper.ps1 help`

### Código de Seeders

- **[general/management/commands/seed_data.py](general/management/commands/seed_data.py)**
  - Comando Django personalizado
  - Seeders con upsert (update_or_create)
  - Datos de ejemplo para todas las tablas

## 🎯 ¿Qué Archivo Necesito?

### Si quieres...

**...empezar rápido:**
→ [LEEME_DOCKER.md](LEEME_DOCKER.md)

**...ver solo los comandos básicos:**
→ [DOCKER_QUICKSTART.md](DOCKER_QUICKSTART.md)

**...entender cómo funciona todo:**
→ [ARQUITECTURA_DOCKER.md](ARQUITECTURA_DOCKER.md)

**...ver todos los comandos disponibles:**
→ [DOCKER_README.md](DOCKER_README.md)

**...usar comandos simplificados:**
→ `.\docker-helper.ps1 help`

**...modificar la configuración:**
→ [docker-compose.yml](docker-compose.yml) o [.env](.env)

**...modificar los datos iniciales:**
→ [general/management/commands/seed_data.py](general/management/commands/seed_data.py)

**...resolver problemas:**
→ [LEEME_DOCKER.md](LEEME_DOCKER.md) (sección "Si algo sale mal")

## 🏗️ Estructura del Proyecto

```
sga_fisi/
│
├── 📄 LEEME_DOCKER.md              ← ⭐ EMPIEZA AQUÍ
├── 📄 DOCKER_QUICKSTART.md         ← Inicio rápido
├── 📄 DOCKER_README.md             ← Documentación completa
├── 📄 ARQUITECTURA_DOCKER.md       ← Diagramas técnicos
├── 📄 INDICE_DOCKER.md            ← Este archivo
│
├── 🐳 docker-compose.yml           ← Configuración de servicios
├── 🐳 Dockerfile                   ← Imagen de Docker
├── 🐳 .dockerignore                ← Archivos a ignorar
├── 🐳 entrypoint.sh                ← Script de inicio
│
├── ⚙️ .env                         ← Variables de entorno
├── ⚙️ .env.example                 ← Ejemplo de configuración
│
├── 🛠️ docker-helper.ps1            ← Script de ayuda
│
├── 📦 general/
│   └── management/
│       └── commands/
│           └── seed_data.py        ← Seeders con upsert
│
└── ... (resto del proyecto Django)
```

## 📝 Comandos Más Usados

```powershell
# Iniciar el proyecto
.\docker-helper.ps1 start
# o
docker-compose up --build

# Ver logs
.\docker-helper.ps1 logs
# o
docker-compose logs -f

# Detener
.\docker-helper.ps1 stop
# o
docker-compose down

# Ver estado
.\docker-helper.ps1 status
# o
docker-compose ps

# Ejecutar seeders
.\docker-helper.ps1 seed
# o
docker-compose exec web python manage.py seed_data

# Acceder al shell
.\docker-helper.ps1 shell
# o
docker-compose exec web bash

# Ver ayuda del script
.\docker-helper.ps1 help
```

## 🎓 Datos Cargados Automáticamente

Los seeders cargan datos de ejemplo para:

- ✅ 6 Facultades
- ✅ 5 Áreas Académicas
- ✅ 3 Escuelas
- ✅ 6 Días de la semana
- ✅ 4 Semestres
- ✅ 4 Locales
- ✅ 8 Aulas
- ✅ 4 Tipos de Curso
- ✅ 4 Planes de Estudio
- ✅ 7 Cursos
- ✅ 4 Tipos de Dictado
- ✅ Horas de dictado

## 🔗 Enlaces Útiles

- **Aplicación**: http://localhost:8000
- **Panel Admin**: http://localhost:8000/admin
  - Usuario: `admin`
  - Password: `admin123`

## ❓ Preguntas Frecuentes

**P: ¿Cómo empiezo?**
R: Lee [LEEME_DOCKER.md](LEEME_DOCKER.md) y ejecuta `.\docker-helper.ps1 start`

**P: ¿Los seeders duplican datos?**
R: No, usan `update_or_create` (upsert), puedes ejecutarlos múltiples veces

**P: ¿Cómo accedo a la base de datos?**
R: `.\docker-helper.ps1 db` o `docker-compose exec db psql -U sga_user -d sga_fisi_db`

**P: ¿Cómo reseteo todo?**
R: `.\docker-helper.ps1 clean` (¡cuidado! borra la BD)

**P: ¿Dónde están los logs?**
R: `.\docker-helper.ps1 logs` o `docker-compose logs -f`

## 🆘 Soporte

Si tienes problemas, revisa:
1. [LEEME_DOCKER.md](LEEME_DOCKER.md) - Sección "Si algo sale mal"
2. [DOCKER_README.md](DOCKER_README.md) - Sección "Solución de Problemas"
3. Los logs: `docker-compose logs -f`

## ✨ Características

- ✅ Docker Compose con PostgreSQL
- ✅ Migraciones automáticas
- ✅ Seeders con upsert
- ✅ Superusuario automático
- ✅ Health checks
- ✅ Volúmenes persistentes
- ✅ Scripts de ayuda
- ✅ Documentación completa

---

**🎉 ¡Todo listo para usar!**

Empieza leyendo [LEEME_DOCKER.md](LEEME_DOCKER.md)
