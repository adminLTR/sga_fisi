# Usar imagen oficial de Python
FROM python:3.11-slim

# Establecer variables de entorno
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Establecer directorio de trabajo
WORKDIR /app

# Instalar dependencias del sistema necesarias para psycopg2 y Pillow
RUN apt-get update && apt-get install -y \
    gcc \
    postgresql-client \
    libpq-dev \
    libjpeg-dev \
    zlib1g-dev \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Copiar requirements y instalar dependencias de Python
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copiar y configurar el script de entrada ANTES de copiar todo
# Esto asegura que tenga los permisos correctos
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh && \
    dos2unix /app/entrypoint.sh 2>/dev/null || sed -i 's/\r$//' /app/entrypoint.sh

# Copiar el proyecto
COPY . /app/

# Crear directorio para logs y media
RUN mkdir -p /app/logs /app/media/aulas

# Exponer el puerto
EXPOSE 8000

# Usar el script de entrada
ENTRYPOINT ["/app/entrypoint.sh"]
