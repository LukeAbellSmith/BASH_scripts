#!/bin/bash

# This is meant to monitor stats from nvidia-smi
# It updates the screen every 5 seconds

while [ true ]
do
	clear
	nvidia-smi
	sleep 5
done
