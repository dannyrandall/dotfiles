#!/bin/bash
############################
# gopass.sh
# this script updates environment variables with the ones stored in gopass.
############################

####### Variables
vars=`gopass environment-variables | cut -c 11- | sed 1d`
passStore="$HOME/.password-store"
gopassSub="environment-variables"
envFile="$HOME/.envrc"
#######

#allow to stop if password needs to be entered
read -r -p "Do you have your gpg key password copied or saved in your keychain? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
        ;;
    *)
		echo ""
        echo "please copy your password and rerun this script." 
		exit 1
        ;;
esac

# create new .envrc, save old ones
mv $envFile $envFile-old 
printf "Moved $envFile to $envFile-old\n"
touch $envFile 

# update gopass
printf "Updating password store at -------->  $passStore\n\t"
git -C $passStore pull
printf "\n\n\n"

# add environement variables
printf "Adding all variables!\n"
for var in $vars; do
	printf "Adding $var...\n"
	secret=`gopass $gopassSub/$var`
	if [ $? -ne 0 ]; then
		printf "\n\n"
		echo "Failed. Please check your gpg key password."
		mv $envFile-old $envFile # restore old file
		exit 1
	fi
	insert="export $var=\"$secret\""
	echo $insert >> $envFile 
	printf "\tSuccess!\n"
done

# done
printf "\n\n"
echo "Please restart your terminal for changes to take effect"
