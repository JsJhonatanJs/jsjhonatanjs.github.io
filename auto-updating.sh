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

# Ejecutar actualización de sitios (si es necesario)
#echo "Actualizando sitios..."
#npm run sites:update || { echo "Warning: Error en sites:update"; }

# Generar EPG
#echo "Generando EPG..."
#npm run grab || { echo "Warning: Error en grab"; }

echo "$(date): Actualización completada exitosamente"