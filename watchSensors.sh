#!/bin/bash

# This is meant to monitor stats from lm-sensors
# It updates the screen every 5 seconds

while [ true ]
do
	clear
	sensors
	sleep 5
done
