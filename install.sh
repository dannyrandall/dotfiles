#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/old_dotfiles             # old dotfiles backup directory
files="zshrc config/bspwm config/sxhkd xinitrc Xdefaults"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from ~.$file to $olddir"
    mv ~/.$file ~/old_dotfiles/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done
