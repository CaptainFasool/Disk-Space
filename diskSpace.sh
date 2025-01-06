#!/bin/bash

thresholdValue=$1

if [[ -z "$thresholdValue" ]]; then
	echo "Insert a % threshold value as an integer argument."
	exit 1
fi

spaceUsedPercentage=$(df -h --total | grep "total" | awk '{print $5}') # Extracts disk usage % value
spaceUsedInteger=$( echo "$spaceUsedPercentage" | tr -d '%') # tr -d stands for translate delete the % character, leaving us with the int value
spaceUsed=$(df -h --total | grep "total" | awk '{print $3}') # Space that has been used in Gb
totalSpace=$(df -h --total | grep "total" | awk '{print $2}') # Total machine disk space in Gb

if [[ "$thresholdValue" -gt "$spaceUsedInteger" ]]; then # Comparison with threshold value
	echo "Disk is using $spaceUsed out of $totalSpace."
	echo "WARNING: Disk usage exceeds your threshold value, and is currently at $spaceUsedPercentage usage."
else
	echo "Disk is using $spaceUsed out of $totalSpace."
	echo "Disk usage is under your threshold value, and is currently at $spaceUsedPercentage usage."
fi

