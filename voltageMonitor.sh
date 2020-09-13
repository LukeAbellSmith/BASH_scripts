#!/bin/bash

# For monitoring mains line voltage.

# Scrape input voltage from an APC NMC2 and display it in the terminal, 
#  updating as quickly as curl can scrape the new voltages.
# The sleep can be uncommented and adjusted for longer intervals.

URL=$(curl -v http://APC_NMC_HOST_OR_IP/home.htm 2>&1 | grep Location | cut -d " " -f3)
URL=$(echo $URL | sed 's/\r$//')

while [ true ]
do
	VOLTAGE=$(curl $URL 2>&1 | grep -A 1 "Input Voltage" | grep "langVAC" | cut -d ">" -f2 | cut -d "&" -f1)
	clear
	echo $VOLTAGE
#	sleep 0.5
done
