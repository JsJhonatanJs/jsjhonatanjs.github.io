#!/bin/bash

# Script de actualización automática para EPG
# Ejecutar desde cron o manualmente

set -e  # Salir si cualquier comando falla

# Cambiar al directorio del proyecto
cd /home/ubuntu/epg || { echo "Error: No se pudo acceder al directorio /home/ubuntu/epg"; exit 1; }

echo "$(date): Iniciando actualización del EPG..."

# Actualizar repositorio
echo "Actualizando repositorio..."
git pull || { echo "Error en git pull"; exit 1; }

# Instalar dependencias
echo "Instalando dependencias..."
npm install || { echo "Error en npm install"; exit 1; }

# Actualizar lista de canales
echo "Actualizando lista de canales..."
npm run channels:parse --- --config=./sites/tv.movistar.com.pe/tv.movistar.com.pe.config.js --output=./sites/tv.movistar.com.pe/tv.movistar.com.pe.channels.xml || { echo "Warning: Error en channels:parse"; }

# Descargar la guía
echo "Descargando la guía..."
npm run grab --- --site=tv.movistar.com.pe || { echo "Warning: Error en grab --- --site=tv.movistar.com.pe"; }

echo "$(date): Actualización completada exitosamente"