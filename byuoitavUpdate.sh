#!/bin/bash

# this script will automatically update all byuoitav repos on their current branch

## variables
parentFolder="$GOPATH/src/github.com/byuoitav"
##

for folder in $parentFolder/*; do 
	printf "updating $(basename $folder)\n\t"	
	cd $folder && git pull -p	
done
