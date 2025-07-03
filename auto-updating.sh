#!/bin/bash

# Script de actualización automática para EPG
# Ejecutar desde cron o manualmente

set -e  # Salir si cualquier comando falla

# Cambiar al directorio del epg
cd /home/ubuntu/epg || { echo "Error: No se pudo acceder al directorio /home/ubuntu/epg"; exit 1; }

echo "$(date): Iniciando actualización del EPG..."

# Actualizar repositorio del EPG
echo "Actualizando repositorio del EPG..."
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

# Cambiar al directorio del repositorio
cd /home/ubuntu/jsjhonatanjs.github.io || { echo "Error: No se pudo acceder al directorio /home/ubuntu/jsjhonatanjs.github.io"; exit 1; }

# Actualizar repositorio
echo "Actualizando repositorio..."
git pull || { echo "Error en git pull"; exit 1; }

# Mover el archivo EPG al repositorio
echo "Moviendo archivo EPG al repositorio..."
mv /home/ubuntu/epg/guide.xml /home/ubuntu/jsjhonatanjs.github.io/guide.xml || { echo "Error al mover el archivo EPG"; exit 1; }

echo "$(date): Actualización completada exitosamente"