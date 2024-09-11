#!/bin/bash
# Script de nettoyage des fichiers temporaires

# Répertoire à nettoyer
TEMP_DIR="${1:-/tmp}"
LOG_FILE="${2:-cleanup.log}"

# Vérifie si le répertoire existe
if [ ! -d "$TEMP_DIR" ]; then
    echo "Le répertoire spécifié n'existe pas: $TEMP_DIR" | tee -a "$LOG_FILE"
    exit 1
fi

# Supprime les fichiers temporaires
echo "Début du nettoyage dans le répertoire : $TEMP_DIR" | tee -a "$LOG_FILE"
find "$TEMP_DIR" -type f -name '*.tmp' -exec rm -v {} \; | tee -a "$LOG_FILE"

echo "Nettoyage terminé." | tee -a "$LOG_FILE"
