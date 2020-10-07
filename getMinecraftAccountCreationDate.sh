#!/bin/bash

#This script will take in a minecraft username and get the date it was created

#Check that user passed in a username, exit if not
UNAME=$1
if [ ${#UNAME} -lt 1 ]
then
	echo "Please pass in a username as an argument (Case sensitive)"
	exit 1
fi


#Check that account exists now, exit if not
NOWDATE=$(date +"%s")
REPLY=$(curl https://api.mojang.com/users/profiles/minecraft/$1?at=$NOWDATE 2>&1 | grep $UNAME)

if [ ${#REPLY} -lt ${#UNAME} ]
then
	echo "That account does not seem to exist (Usernames are case sensitive)"
	exit 1
fi


#Initialize variables
INIT_DATE=1275436799
CURR_DATE=$INIT_DATE
INCREMENT=86400
REPLY="empty"


echo "Checking age of Minecraft user '$UNAME'"


#Jump Years
while [ ${#REPLY} -lt ${#UNAME} ]
do
    CURR_DATE=$(( $CURR_DATE + $INCREMENT * 365 ))
    REPLY=$(curl https://api.mojang.com/users/profiles/minecraft/$1?at=$CURR_DATE 2>&1 | grep $UNAME )
done


#Reset/tweak variables for next run
REPLY="empty"
CURR_DATE=$(( $CURR_DATE - $INCREMENT * 365 ))


#Jump Months
while [ ${#REPLY} -lt ${#UNAME} ]
do
	CURR_DATE=$(( $CURR_DATE + $INCREMENT * 30 ))
	REPLY=$(curl https://api.mojang.com/users/profiles/minecraft/$1?at=$CURR_DATE 2>&1 | grep $UNAME )
done


#Reset/tweak variables for next run
REPLY="empty"
CURR_DATE=$(( $CURR_DATE - $INCREMENT * 30 ))


#Increment days
while [ ${#REPLY} -lt ${#UNAME} ]
do
	CURR_DATE=$(( $CURR_DATE + $INCREMENT ))
	REPLY=$(curl https://api.mojang.com/users/profiles/minecraft/$1?at=$CURR_DATE 2>&1 | grep $UNAME )
done

#Output result
DATE=$(date -d @$CURR_DATE +'%F')
echo "$UNAME account appears to have been created on $DATE"
