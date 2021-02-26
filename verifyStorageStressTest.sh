#!/bin/bash

#This will just run f3write and f3read 10 times printing the write speeds and any errors
#This script requires f3 (Fight Flash Fraud)
#You may pass in a number to specify how many loops

#Default number of runs
LOOPS=10

#Set loops if specified
if [ $# -gt 0 ]
then
	LOOPS=$1
fi


echo Verifying $PWD $LOOPS times
echo Only free space will be tested

rm ./*.h2w &> /dev/null

#Do the loops
i=1
for (( i=1; i<=$LOOPS; i++ ))
do
	f3write . | grep writing
	f3read . | grep 'LOST\|speed'
	rm *.h2w
	echo Round $i complete
done

echo Done
