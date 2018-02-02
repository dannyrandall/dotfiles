# for my zsh theme

ZSH_CUSTOM_THEMES_DIR=$HOME/.oh-my-zsh/custom/themes

cd $ZSH_CUSTOM_THEMES_DIR 
git clone https://github.com/geometry-zsh/geometry
cd geometry
git submodule update --init --recursive
