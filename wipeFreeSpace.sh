#!/bin/bash

# This script is meant to shred empty drive space
#  (Irrecoverably overwrite free space)
# It is not perfectly polished, and I make no guarantees of efficacy, but it seems to work.

#This script SHOULD not be destructive to existing data*
# BUT I take no liability for any loss of data.
# (*Any files in the working directory named zero or urandom will be destroyed.)

#More types of wipe?

#Add filesystem type check?
# (warn FAT will not wipe whole drive because 4G size limit)


#Number of times to write urandom
LOOPS=3

#Name of source and destination data
DATA=""
#Pass number
PASS=""

wipe()
{
	#Write data
	echo "Writing $DATA $PASS"
	cat /dev/$DATA > ./$DATA 2> /dev/null

	fullCheck

	#Erase data file
	echo "Erasing $DATA"
	rm ./$DATA
}

fullCheck()
{
	#See if drive is full, complain if not (also set a flag for the end)
	USED=$(df -Th | grep "$(pwd)" | awk '{print $6}')
	if [ "$USED" != "100%" ]
	then
		echo "DRIVE NOT FILLED!"
		echo "$PWD is $USED full"
	fi
}

yesWipe()
{
	echo "Writing $yesSTRING"
	yes $yesSTRING > ./yesFile 2> /dev/null

	fullCheck

	echo "Erasing custom string file"
	rm ./yesFile
}



if [ $# -eq 1 ]
then
	LOOPS=$1
fi

## START
echo "Wiping free space of $PWD"
echo
echo "Will write zero to the device until full"
echo " Then will write random data $LOOPS times"
echo "  Then will write zero again"
echo "Starting in 5 seconds (ctrl+c to abort)"
echo
sleep 5

# ZERO WIPE
DATA="zero"
wipe

echo "Phase One Complete (zero)"
echo

## RANDOM LOOP
if [ $LOOPS -ge 1 ]
then
	echo "Writing random data $LOOPS times"
	DATA="urandom"
	for i in `eval echo {1..$LOOPS}`
	do
		PASS="Pass $i"
		wipe
	done

echo "Phase Two Complete (URand passes)"
echo
fi

## ZERO WIPE
DATA="zero"
PASS=""
wipe

## END
echo "Wrote Zero once and URand $LOOPS times then Zero again."

echo "Free space wipe Complete"

