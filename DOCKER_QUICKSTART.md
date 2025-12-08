# 🚀 Inicio Rápido - Docker

## Levanta el proyecto en 3 pasos:

### 1️⃣ Asegúrate de tener Docker Desktop corriendo

### 2️⃣ Ejecuta uno de estos comandos:

**Opción A - Con el script helper:**
```powershell
.\docker-helper.ps1 start
```

**Opción B - Comando directo:**
```powershell
docker-compose up --build
```

### 3️⃣ Accede al sistema:

- 🌐 Aplicación: http://localhost:8000
- 🔐 Admin: http://localhost:8000/admin
  - Usuario: `admin`
  - Contraseña: `admin123`

## ✨ ¿Qué hace automáticamente?

✅ Crea y configura PostgreSQL  
✅ Ejecuta todas las migraciones  
✅ Carga datos de ejemplo (seeders con upsert)  
✅ Crea el superusuario admin  
✅ Levanta el servidor en el puerto 8000  

## 📚 Más información

Ver `DOCKER_README.md` para documentación completa.

## 🛠️ Comandos útiles:

```powershell
# Ver logs
docker-compose logs -f

# Detener
docker-compose down

# Reiniciar
docker-compose restart

# O usa el script helper:
.\docker-helper.ps1 help
```

---
**¡Listo para usar!** 🎉
