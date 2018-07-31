#!/usr/bin/env bash

envfile=$1
if [ -z "$envfile" ]; then
    echo -e "must include a file to write vars to."
    exit 1
fi

mv $envfile $envfile.old

IFS=$'\n'
list=$(lpass ls "Shared-The Cube/env-vars/")

for item in $list; do
    [ -z "$item" ] && continue # skip empty items    

    id=$(echo "$item" | grep -o -P "(?!<=\[id:)[0-9]*(?=\])")
    name=$(lpass show --name "$id")
    pass=$(lpass show --password "$id")

    echo -e "export $name=\"$pass\"" >> $envfile
    echo "Added $name"
done

unset IFS

echo "finished!"
