#!/bin/bash
set -e

echo "==================================="
echo "Iniciando SGA FISI Web Application"
echo "==================================="

# Configurar variables de entorno por defecto
DB_HOST=${DB_HOST:-db}
DB_PORT=${DB_PORT:-5432}
DB_USER=${DB_USER:-sga_user}

# Esperar a que PostgreSQL estÃ© disponible
echo "â³ Esperando a que PostgreSQL estÃ© disponible en $DB_HOST:$DB_PORT..."
MAX_RETRIES=30
RETRY_COUNT=0

while ! pg_isready -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" > /dev/null 2>&1; do
  RETRY_COUNT=$((RETRY_COUNT + 1))
  if [ $RETRY_COUNT -ge $MAX_RETRIES ]; then
    echo "âŒ ERROR: PostgreSQL no estÃ¡ disponible despuÃ©s de $MAX_RETRIES intentos"
    exit 1
  fi
  echo "   Intento $RETRY_COUNT/$MAX_RETRIES..."
  sleep 2
done

echo "âœ… PostgreSQL estÃ¡ listo!"

# Crear migraciones si no existen
echo "ðŸ“ Creando migraciones..."
python manage.py makemigrations --noinput || true

# Ejecutar migraciones
echo "ðŸ”„ Ejecutando migraciones..."
python manage.py migrate --noinput

# Recolectar archivos estÃ¡ticos
echo "ðŸ“¦ Recolectando archivos estÃ¡ticos..."
python manage.py collectstatic --noinput --clear

# Ejecutar seeders (si existe el comando)
if python manage.py help seed_data > /dev/null 2>&1; then
    echo "ðŸŒ± Ejecutando seeders..."
    python manage.py seed_data || echo "âš ï¸  Seeders no disponibles o fallaron"
fi

# Crear superusuario si no existe
echo "ðŸ‘¤ Verificando superusuario..."
python manage.py shell << END || true
from django.contrib.auth import get_user_model
User = get_user_model()
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@sga.com', 'admin123')
    print('âœ… Superusuario creado: admin/admin123')
else:
    print('â„¹ï¸  Superusuario ya existe')
END

echo "==================================="
echo "âœ… InicializaciÃ³n completada!"
echo "ðŸš€ Iniciando servidor..."
echo "==================================="

# Ejecutar el comando que se pase como argumento
exec "$@"
