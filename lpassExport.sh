#!/usr/bin/env bash

envfile=$1
echo -e "Exporting env vars from $envfile into lastpass."

while IFS= read -r line; do
    [ -z "$line" ] && continue # skip empty lines
    [[ "$line" =~ \#.* ]] && continue # skip comments

    env=$(echo $line | sed -e 's/\<export\>//g') # remove 'export'

    IFS="=" read -r -a split <<< "$env" # split the key/value
    echo -e "Adding ${split[0]#" "}..."

    echo -e "Username:\nPassword:${split[1]//\"}" | lpass add --sync=auto --non-interactive "Shared-The Cube/env-vars/${split[0]#" "}"
    echo -e "\tsuccess."

done <"$envfile"
unset IFS

echo "finished!"

