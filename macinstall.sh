#!/bin/bash
############################
# install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/old_dotfiles             # old dotfiles backup directory
files="zshrc vimrc"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old
echo "Creating $olddir for backup of any exisiting dotfiles in ~"
mkdir -p $olddir
printf "\t...done"

# change to the dotfiles directory
cd $dir

# move any existing dotfiles in to dotfiles_old, then create symlinks
for file in $files; do
	printf "Moving ~.$file to $olddir"
	mv ~/.$file ~/$olddir
	printf "Creating symlink from $dir/$file to ~/.$file"
	ln -s $dir/$file ~/.$file
done
echo "Done symlinking dotfiles!\n\n"

# download backgrounds from unsplash
./backgrounds.sh
