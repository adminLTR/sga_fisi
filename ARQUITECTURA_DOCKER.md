# 🏗️ Arquitectura Docker - SGA FISI

## 📦 Estructura de Contenedores

```
┌─────────────────────────────────────────────────────────────┐
│                     Docker Compose                           │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌────────────────────────┐    ┌─────────────────────────┐ │
│  │   Contenedor: web      │    │   Contenedor: db        │ │
│  │                        │    │                         │ │
│  │  Python 3.11           │───▶│  PostgreSQL 15          │ │
│  │  Django 5.2.6          │    │                         │ │
│  │  Gunicorn 23.0         │    │  BD: sga_fisi_db        │ │
│  │                        │    │  User: sga_user         │ │
│  │  Puerto: 8000          │    │  Puerto: 5432           │ │
│  │                        │    │                         │ │
│  └────────────────────────┘    └─────────────────────────┘ │
│           │                              │                   │
│           │                              │                   │
│  ┌────────▼──────────┐         ┌────────▼──────────┐       │
│  │ Volumen: media    │         │ Volumen: postgres │       │
│  │ /app/media        │         │ /var/lib/postgres │       │
│  └───────────────────┘         └───────────────────┘       │
│                                                               │
│  ┌─────────────────┐                                        │
│  │ Volumen: static │                                        │
│  │ /app/static     │                                        │
│  └─────────────────┘                                        │
│                                                               │
└─────────────────────────────────────────────────────────────┘
         │
         │ Puerto 8000
         ▼
    [localhost:8000]
```

## 🔄 Flujo de Inicio (entrypoint.sh)

```
1. 🔌 Esperar PostgreSQL
   └─▶ Verificar conexión cada 1 segundo
   
2. 📝 Crear migraciones
   └─▶ python manage.py makemigrations
   
3. 🗃️ Ejecutar migraciones
   └─▶ python manage.py migrate
   
4. 📁 Recolectar estáticos
   └─▶ python manage.py collectstatic
   
5. 🌱 Ejecutar seeders
   └─▶ python manage.py seed_data (con upsert)
   
6. 👤 Crear superusuario
   └─▶ admin/admin123 (si no existe)
   
7. 🚀 Iniciar Gunicorn
   └─▶ 3 workers en puerto 8000
```

## 🌱 Flujo de Seeders (seed_data.py)

```
┌─────────────────────────────────────────────────┐
│          Comando: seed_data                     │
│    (usa update_or_create para upsert)          │
└─────────────────────────────────────────────────┘
              │
              ├─▶ 1. Facultades (6)
              │   └─▶ FISI, FIM, FIEE, FIGMM, FIQ, FC
              │
              ├─▶ 2. Áreas Académicas (5)
              │   └─▶ Informática, Matemáticas, etc.
              │
              ├─▶ 3. Escuelas (3)
              │   └─▶ IS, SW, CC
              │
              ├─▶ 4. Días (6)
              │   └─▶ Lunes a Sábado
              │
              ├─▶ 5. Semestres (4)
              │   └─▶ 2024-I/II, 2025-I/II
              │
              ├─▶ 6. Locales (4)
              │   └─▶ Pabellones FISI, FIM, etc.
              │
              ├─▶ 7. Aulas (8)
              │   └─▶ A-101 a A-301, LAB-1 a LAB-3
              │
              ├─▶ 8. Tipos de Curso (4)
              │   └─▶ Obligatorio, Electivo, etc.
              │
              ├─▶ 9. Planes de Estudio (4)
              │   └─▶ 2018-IS, 2020-IS, etc.
              │
              ├─▶ 10. Cursos (7)
              │    └─▶ Matemáticas, Base de Datos, etc.
              │
              ├─▶ 11. Tipos de Dictado (4)
              │    └─▶ Teoría, Práctica, etc.
              │
              └─▶ 12. Horas de Dictado
                   └─▶ Configuración por curso
```

## 📂 Estructura de Aplicaciones Django

```
sga_fisi/
├── general/              # App: Datos generales
│   ├── models.py
│   │   ├─▶ Facultad
│   │   ├─▶ AreaAcademica
│   │   ├─▶ Escuela
│   │   └─▶ Dia
│   └── management/
│       └── commands/
│           └── seed_data.py  ← Comando de seeders
│
├── vicerrectorado/       # App: Vicerrectorado
│   └── models.py
│       └─▶ Semestre
│
├── administrativo/       # App: Administrativo
│   └── models.py
│       ├─▶ Local
│       ├─▶ Aula
│       └─▶ GrupoHorario
│
└── escuela/              # App: Escuela
    └── models.py
        ├─▶ PlanEstudio
        ├─▶ CursoTipo
        ├─▶ Curso
        ├─▶ CursoPrerequisito
        ├─▶ CursoEquivalente
        ├─▶ Grupo
        ├─▶ CursoTipoDictado
        └─▶ CursoHorasDictado
```

## 🔗 Relaciones entre Modelos

```
Facultad ─┬─▶ Escuela ──▶ PlanEstudio ──▶ Curso
          │                                   │
AreaAcad ─┘                                   ├─▶ Grupo ──▶ GrupoHorario
                                              │      │            │
Semestre ────────────────────────────────────┘      │            │
                                                     │            │
CursoTipo ──────────────────────────────────────────┘            │
                                                                  │
Local ──▶ Aula ──────────────────────────────────────────────────┘
                                                                  
Dia ──────────────────────────────────────────────────────────────┘

CursoTipoDictado ──▶ CursoHorasDictado ◀── Curso
```

## 🔐 Variables de Entorno (.env)

```
Django Settings:
├─▶ SECRET_KEY        # Clave secreta de Django
├─▶ DEBUG             # Modo debug (True/False)
├─▶ ALLOWED_HOSTS     # Hosts permitidos
└─▶ CSRF_TRUSTED      # Orígenes confiables

Database Settings:
├─▶ DB_NAME          # sga_fisi_db
├─▶ DB_USER          # sga_user
├─▶ DB_PASS          # sga_password
├─▶ DB_HOST          # db (nombre del servicio)
└─▶ DB_PORT          # 5432
```

## 📊 Puertos y Servicios

```
┌──────────────┬─────────┬──────────────────────────┐
│   Servicio   │  Puerto │       Acceso             │
├──────────────┼─────────┼──────────────────────────┤
│ Django       │  8000   │ http://localhost:8000    │
│ PostgreSQL   │  5432   │ localhost:5432           │
│ Admin Panel  │  8000   │ /admin                   │
└──────────────┴─────────┴──────────────────────────┘
```

## 🎯 Comandos Principales

```
Gestión de Contenedores:
├─▶ docker-compose up --build    # Construir y levantar
├─▶ docker-compose down          # Detener
├─▶ docker-compose restart       # Reiniciar
├─▶ docker-compose logs -f       # Ver logs
└─▶ docker-compose ps            # Ver estado

Gestión de Django (dentro del contenedor):
├─▶ python manage.py migrate     # Ejecutar migraciones
├─▶ python manage.py seed_data   # Ejecutar seeders
├─▶ python manage.py shell       # Shell de Django
└─▶ python manage.py createsuperuser  # Crear admin

Helper Script:
├─▶ .\docker-helper.ps1 start    # Iniciar
├─▶ .\docker-helper.ps1 logs     # Ver logs
├─▶ .\docker-helper.ps1 shell    # Acceder al shell
└─▶ .\docker-helper.ps1 help     # Ver ayuda
```

## 💾 Persistencia de Datos

```
Datos Persistentes (Volúmenes):
├─▶ postgres_data    # Base de datos PostgreSQL
├─▶ media_volume     # Archivos media (imágenes)
└─▶ static_volume    # Archivos estáticos

Datos Efímeros:
└─▶ Logs de aplicación (se pierden al reiniciar)
```

## ⚡ Health Checks

```
PostgreSQL:
├─▶ Comando: pg_isready -U sga_user
├─▶ Intervalo: cada 5 segundos
├─▶ Timeout: 5 segundos
└─▶ Reintentos: 5

Aplicación Web:
└─▶ Espera a que PostgreSQL esté saludable
```

## 🎨 Características Implementadas

```
✅ Dockerización Completa
   ├─▶ Dockerfile optimizado
   ├─▶ docker-compose.yml
   ├─▶ .dockerignore
   └─▶ Multi-stage build support

✅ Base de Datos
   ├─▶ PostgreSQL 15
   ├─▶ Volumen persistente
   ├─▶ Health checks
   └─▶ Configuración automática

✅ Migraciones Automáticas
   ├─▶ makemigrations
   ├─▶ migrate
   └─▶ Al iniciar el contenedor

✅ Seeders con Upsert
   ├─▶ update_or_create
   ├─▶ Datos de ejemplo
   └─▶ Seguro para múltiples ejecuciones

✅ Usuario Admin
   ├─▶ Creación automática
   ├─▶ Usuario: admin
   └─▶ Password: admin123

✅ Servidor WSGI
   ├─▶ Gunicorn
   ├─▶ 3 workers
   └─▶ Timeout: 120s

✅ Scripts de Ayuda
   ├─▶ docker-helper.ps1
   ├─▶ entrypoint.sh
   └─▶ Documentación completa
```

---

**🎉 Todo listo para producción y desarrollo!**
