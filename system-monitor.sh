#!/bin/bash

# Script de surveillance du système
# Affiche l'utilisation du CPU, de la mémoire et de l'espace disque

# Obtenir l'utilisation du CPU
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')

# Obtenir l'utilisation de la mémoire
mem_usage=$(free -m | awk 'NR==2{printf "Mémoire utilisée: %sMB / %sMB (%.2f%%)\n", $3, $2, $3*100/$2 }')

# Obtenir l'utilisation de l'espace disque
disk_usage=$(df -h | grep "^/dev/" | awk '{ print $1 " (" $6 "): " $5 " utilisé"}')

# Afficher les résultats
echo "Surveillance des ressources système :"
echo "-----------------------------------"
echo "Utilisation du CPU : $cpu_usage"
echo "$mem_usage"
echo "Utilisation de l'espace disque :"
echo "$disk_usage"
