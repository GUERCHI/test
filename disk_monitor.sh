#!/bin/bash
# Script de surveillance de l'espace disque

# Seuil d'avertissement en pourcentage
THRESHOLD=90

# Obtenir l'espace libre en pourcentage pour la partition racine
USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

# Vérifier si l'utilisation dépasse le seuil
if [ "$USAGE" -ge "$THRESHOLD" ]; then
    echo "Avertissement : L'espace disque est presque plein sur / (utilisation à $USAGE%)" | tee -a /var/log/disk_monitor.log
else
    echo "L'espace disque est suffisant (utilisation à $USAGE%)" | tee -a /var/log/disk_monitor.log
fi
