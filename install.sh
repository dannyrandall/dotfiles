#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/old_dotfiles             # old dotfiles backup directory
files="zshrc xinitrc Xdefaults vimrc"    # list of files/folders to symlink in homedir
configFiles="bspwm sxhkd"

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

# do the same for the config folders
mkdir $olddir/config
for folder in $configFiles; do
    echo "Moving existing config folders from ~/.config/$folder to ~$olddir/config/"
    mv ~/.config/$folder ~/old_dotfiles/config/
    echo "Creating symlink to $folder in home directory."
    ln -s $dir/config/$folder ~/.config/$folder
done
