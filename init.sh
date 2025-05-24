#!/bin/bash

DB_NAME="chat_ia"
DB_USER="postgres"

echo "📦 Iniciando creación de base de datos PostgreSQL como usuario '$DB_USER'..."

# Crear la base de datos si no existe
sudo -u "$DB_USER" psql -tc "SELECT 1 FROM pg_database WHERE datname = '$DB_NAME'" | grep -q 1 || \
  sudo -u "$DB_USER" psql -c "CREATE DATABASE $DB_NAME"

# Activar pgvector si no existe
echo "🔌 Verificando y activando extensión pgvector..."
sudo -u "$DB_USER" psql -d "$DB_NAME" -c "CREATE EXTENSION IF NOT EXISTS vector;" 2>/dev/null

# Ejecutar scripts SQL por orden
echo "📄 Ejecutando 001_create_tables.sql..."
sudo -u "$DB_USER" psql -d "$DB_NAME" -f schema/001_create_tables.sql

echo "⚙️ Ejecutando 002_create_indexes.sql..."
sudo -u "$DB_USER" psql -d "$DB_NAME" -f schema/002_create_indexes.sql

echo "🧪 Ejecutando 003_insert_initial_data.sql..."
sudo -u "$DB_USER" psql -d "$DB_NAME" -f schema/003_insert_initial_data.sql

echo "✅ Base de datos '$DB_NAME' inicializada correctamente."

