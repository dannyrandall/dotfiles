#!/bin/bash

###############################
# Unsplash Collection Downloader
##### from Daniel Randall
###############################
#
# This script will download the full versions of images from a collection on unsplash.com
# Change the url's collection ID (defaults to mine, 620389) to change the collection that is downloaded.
# You can also change where they are downloaded to by changing $folder and $old_folder.
# Images will be saved with .jpg extension, in the form of bg<image number>.jpg
#

## variables
collectionURL="https://unsplash.com/collections/620389/"  # url to download backgrounds from
folder="$HOME/pictures/backgrounds" #folder to save to
oldFolder="$HOME/pictures/old_backgrounds" # folder to move whatever was in $folder before to
##

echo "Moving old backgrounds to $oldFolder"
mkdir -p $oldFolder; cd $oldFolder; rm -r $oldFolder/* ; mv $folder/* $oldFolder # clear $oldFolder, move stuff in $folder to $oldFolder
echo "Downloading index.html from $collectionURL"
cd; mkdir -p $folder; cd $folder; rm $folder/*
wget -A.html $collectionURL
pictureURLs=`grep '\"full\":' index.html | grep -o 'https://.*\"' | sed 's/"$//'`
rm index.html # delete index.html 

# iterate through each pictureURL, download image from that URL
num=1
for url in $pictureURLs; do 
	echo "Downloading picture from $url, saving as bg$num"
	wget -O bg$num.jpg $url 
	((num++))	
done

