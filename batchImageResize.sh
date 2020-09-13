#!/bin/bash
# This script will create resized versions of all images in the current directory with
#  the specified dimensions (Or less than; It maintains aspect ratio) 
#  and put them in a subdirectory 'resized'

if [ -z "$1" ] || [ -z "$2" ]
then
    echo "Please specify max width and max height"
    echo "ex:"
    echo "./batchresize 1000 1000"
    exit 1
fi

#Is imagemagick installed?
if [ ! convert ]
then
    echo "Please install ImageMagick"
    exit 2
fi

#Does destination directory exist?
if [ ! -d resized ]
then
	mkdir resized
	echo "Created directory 'resized'"
fi

#Do the resize
echo "Resizing images to $1x$2 (or smaller; maintaining aspect ratio) and putting result in 'resized'"
for f in * ; do 
if [ $f != "batchResize.sh" ]
then
	convert $f -resize $1x$2 resized/$f &> /dev/null
fi

done

 
