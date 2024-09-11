#!/bin/bash

# Variables
SOURCE_DIR="/home/marwa/Documents"
REMOTE_USER="root"
REMOTE_HOST="192.168.250.141"
REMOTE_DIR="/backup/marwa"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="/var/log/backup.log"

# Créer un fichier de log si nécessaire
touch $LOG_FILE

# Afficher les variables pour débogage
echo "SOURCE_DIR: $SOURCE_DIR" >> $LOG_FILE
echo "REMOTE_USER: $REMOTE_USER" >> $LOG_FILE
echo "REMOTE_HOST: $REMOTE_HOST" >> $LOG_FILE
echo "REMOTE_DIR: $REMOTE_DIR" >> $LOG_FILE
echo "DATE: $DATE" >> $LOG_FILE

# Créer les répertoires sur la machine distante
ssh $REMOTE_USER@$REMOTE_HOST "mkdir -p $REMOTE_DIR/backup_$DATE" >> $LOG_FILE 2>&1

# Vérifier si la création des répertoires a réussi
if [ $? -eq 0 ]; then
    echo "[$DATE] Répertoires créés avec succès sur $REMOTE_HOST" >> $LOG_FILE
else
    echo "[$DATE] Échec de la création des répertoires sur $REMOTE_HOST" >> $LOG_FILE
fi

# Utiliser rsync pour copier les fichiers sur la machine distante via SSH
rsync -avz -e ssh $SOURCE_DIR/ $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/backup_$DATE/ >> $LOG_FILE 2>&1

# Vérifier si la sauvegarde a réussi
if [ $? -eq 0 ]; then
    echo "[$DATE] Sauvegarde réussie vers $REMOTE_HOST:$REMOTE_DIR/backup_$DATE" >> $LOG_FILE
else
    echo "[$DATE] Échec de la sauvegarde vers $REMOTE_HOST:$REMOTE_DIR" >> $LOG_FILE
fi
