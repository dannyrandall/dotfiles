## Setup

Setup has only been tested on Arch Linux (``backgrounds.sh`` has been tested on Mac OSX Sierra as well) , and as such, all commands are made with that in mind.
Before setting up dotfiles, install required programs:
* [urxvt](https://wiki.archlinux.org/index.php/rxvt-unicode)
  ```
  pacman -S rxvt-unicode
  ```
* [bspwm](https://github.com/baskerville/bspwm) and [sxhkd](https://github.com/baskerville/sxhkd)
  ```
  pacman -S bspwm sxhkd
  ```
* [zsh](https://wiki.archlinux.org/index.php/zsh)
  ```
  pacman -S zsh
  ```
* [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
  ```
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  ```
* [powerline fonts](https://github.com/powerline/fonts)
  ```
  pacman -S powerline
  ```
* [powerlevel9k theme](https://github.com/bhilburn/powerlevel9k#installation)
  ```
  git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
  ```
* [feh](https://wiki.archlinux.org/index.php/feh)
  ```
  pacman -S feh
  ```
* install [vim-plug](https://github.com/junegunn/vim-plug)
  ``
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  ``
  Post ``./install.sh``, open vim and run
	```
	:source %
	:PlugInstall
	```
* download backgrounds
	* backgrounds are automatically downloaded by running ``install.sh``
	* you can also just download backgrounds with ``backgrounds.sh``
