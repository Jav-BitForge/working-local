#!/bin/bash
set -e

# Archivos
ENV_FILE=".env"
TEMPLATE_FILE="kong.yml.template"
OUTPUT_FILE="kong.yml"

# Verificar existencia de archivos
if [ ! -f "$ENV_FILE" ]; then
  echo "❌ No se encontró el archivo $ENV_FILE"
  exit 1
fi

if [ ! -f "$TEMPLATE_FILE" ]; then
  echo "❌ No se encontró la plantilla $TEMPLATE_FILE"
  exit 1
fi

# Exportar variables, ignorando líneas con #
echo "🔄 Cargando variables del entorno..."
while IFS='=' read -r key value; do
  if [[ ! "$key" =~ ^# && "$key" != "" ]]; then
    export "$key"="$value"
  fi
done < <(sed 's/\r$//' "$ENV_FILE")  # Elimina \r por si acaso

# Confirmar que las IPs fueron cargadas
echo "✅ Variables IP cargadas:"
env | grep '_IP'

# Reemplazar variables
echo "📄 Generando $OUTPUT_FILE..."
envsubst < "$TEMPLATE_FILE" > "$OUTPUT_FILE"

echo "🎉 Archivo generado correctamente: $OUTPUT_FILE"
