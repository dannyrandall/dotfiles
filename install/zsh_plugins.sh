#!/usr/bin/env zsh
# 
# call using . ./zsh-plugins.sh

# clear out old stuff
rm -rf $ZSH_CUSTOM/themes/*
rm -rf $ZSH_CUSTOM/plugins/*

# for geometry zsh theme
git clone https://github.com/geometry-zsh/geometry $ZSH_CUSTOM/themes/geometry
cd $ZSH_CUSTOM/themes/geometry
git submodule update --init --recursive

# install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

# install zsh-syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
