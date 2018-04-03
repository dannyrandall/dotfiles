## Setup

Setup has only been tested on Arch Linux (my mac dotfiles are in [this](https://github.com/dgrandall/dotfiles/tree/mac) branch), and as such, all commands are made with that in mind.
Before setting up dotfiles, install required programs:
* [yaourt](https://archlinux.fr/yaourt-en)
  * edit pacman config file ``sudo vim /etc/pacman.conf``
  * add this repo at the bottom
	```
	[archlinuxfr]
	SigLevel = Never
	Server = http://repo.archlinux.fr/$arch
	```
  * then install yaourt ``sudo pacman -Sy yaourt``
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
* [powerline fonts](https://github.com/powerline/fonts) and [fonts for the web](https://github.com/google/fonts)
  ```
  yaourt -S powerline-fonts-git
  yaourt -S ttf-google-fonts-git
  ```
* [powerlevel9k theme](https://github.com/bhilburn/powerlevel9k#installation)
  ```
  git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
  ```
* [feh](https://wiki.archlinux.org/index.php/feh)
  ```
  pacman -S feh
  ```
* [i3lock-fancy](https://github.com/meskarune/i3lock-fancy)
  ```
  yaourt -S i3lock-fancy-git
  ```
* [go](https://golang.org/)
  ```
  pacman -S go
  ```
* [clang](https://clang.llvm.org/)
  ```
  pacman -S clang
  ```
* [cmake](https://cmake.org/)
  ```
  pacman -S cmake
  ```
* install [vim-plug](https://github.com/junegunn/vim-plug)
  ```
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  ```
  After running ``./install.sh``, open vim and run
	```
	:source %
	:PlugInstall
	```
* [gopass](https://github.com/justwatchcom/gopass)
	* lots of setup required. to install, use ``yaourt -S gopass`` 
* [acpilight](https://github.com/wavexx/acpilight)
	* for backlight control
	```
	yaourt -S acpilight 
	```
* download backgrounds
	* backgrounds are automatically downloaded by running ``install.sh``
	* you can also update/download backgrounds by just running ``backgrounds.sh``
