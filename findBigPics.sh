#!/bin/bash

#Recursively search starting at the specified location
# and copy all images larger than 2000 to the specified path

#Get the path to work on
echo Working directory is: $1
echo Destination directory is: $2
DEST=$2

if [ ! -d $2 ]
then
	echo $2 does not exist. Creating it now.
	mkdir $2
fi

cd $1
PWD=$(pwd)
#echo PWD = $PWD


process_dir()
{
PWD=$(pwd)
for file in *
do
	CURRFILE="$PWD/$file"
	#echo $CURRFILE
	if [ -d "$PWD/$file" ]
	then
#		echo -ne "" #$file is a directory
		(cd -- "$PWD/$file" && process_dir)
	elif [ ${CURRFILE: -4} == ".jpg" ] || [ ${CURRFILE: -4} == ".png" ] || [ ${CURRFILE: -5} == ".jpeg" ] 
	then
		WIDE=$(identify -format '%w' "$PWD/$file")
		HIGH=$(identify -format '%h' "$PWD/$file")
		if [ $WIDE -gt 2000 ] || [ $HIGH -gt 2000 ]
		then
#			echo $PWD/$file is $WIDE wide by $HIGH high
			cp "$PWD/$file" $DEST
		fi
	fi
done
}


#Start processing at the current location
process_dir "$PWD" 

echo Done.
