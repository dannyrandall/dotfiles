## Setup

Setup has only been tested on Arch Linux (``backgrounds.sh`` has been tested on Mac OSX Sierra as well) , and as such, all commands are made with that in mind.
Before setting up dotfiles, install required programs:
* urxvt
  ```
  pacman -S rxvt-unicode
  ```
* bspwm and sxhkd
  ```
  pacman -S bspwm sxhkd
  ```
* zsh
  ```
  pacman -S zsh
  ```
* oh-my-zsh
    * read more about [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
    ```
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  ```
* powerline fonts
  ```
  pacman -S powerline
  ```
* powerlevel9k theme
    * go to .oh-my-zsh/custom, and then run
      ```
      git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
      ```
* feh
  ```
  pacman -S feh
  ```
* download backgrounds
	* backgrounds are automatically downloaded by running ``install.sh``
	* you can also just download backgrounds with ``backgrounds.sh``
