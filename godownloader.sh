#!/bin/bash

# This script will download all go repositories availalbe from a specific Github user/orginization, using go get {url}
# It will also change the git remote to use ssh.

## variables
name=$1
##

urls=`curl -s https://api.github.com/users/$name/repos?per_page=200 | grep "full_name" | cut -d: -f2- | grep -o -P '(?<=\").*(?=\")'`

for url in $urls; do 
	echo "getting repo: $url"
	sub=`echo $url | cut -d/ -f2-`
	printf "\t"
	go get github.com/$url

	cd $GOPATH/src/github.com/$name/$sub && git remote set-url origin git@github.com:$name/$sub.git 
done
