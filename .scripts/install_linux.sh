#!/bin/bash
echo "$UNAME"
echo "$OSTYPE"

if [ $OSTYPE = "linux-gnu" ]
then
	echo "Instalando Linux"
 	if [[ -f /etc/arch-release ]]
	then
		echo "Instalando Archlinux"
		pkg_manager=pacman
		echo "Actualizando sistema"
		sudo pacman -Syu
 	fi
fi

echo "Instalando git"
if [ $pkg_manager = "pacman" ]
then
	sudo pacman -S --noconfirm git
fi


echo "Instalando NeoVim + clipboard"
if [ $pkg_manager = "pacman" ]
then
	sudo pacman -S --noconfirm neovim xclip
fi

if [[ $(command -v rofi) ]]
then
	echo "Instalando Rofi"
	if [ $pkg_manager = "pacman" ]
	then
		sudo pacman -S --noconfirm rofi
	fi
fi


if [[ $(command -v zsh) ]]
then
	echo "Instalando ZSH y ZIM"
	if [ $pkg_manager = "pacman" ]
	then
		sudo pacman -S --noconfirm zsh
		chsh -s $(which zsh)

		curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
		zimfw install

	fi
fi

#echo "Instalando Alacriti"
#if [ $pkg_manager = "pacman" ]
#then
#	curl https://sh.rustup.rs -sSf | sh
#	pacman -S --noconfirm cmake freetype2 fontconfig pkg-config make libxcb libxkbcommon python
#	cargo install alacritty
#fi



if [[ $(command -v kitty) ]]
then
	echo "Instalando Kitty"
	if [ $pkg_manager = "pacman" ]
	then
		pacman -S --noconfirm kitty 
		THEME=https://raw.githubusercontent.com/dexpota/kitty-themes/master/themes/Espresso.conf
		wget "$THEME" -P ~/.config/kitty/kitty-themes/themes
		cd ~/.config/kitty && ln -s ./kitty-themes/themes/Espresso.conf ~/.config/kitty/theme.conf
	fi
fi

echo "Instalando YADM"
if [ $pkg_manager = "pacman" ]
then
	sudo pacman -S --noconfirm yadm
	yadm clone git@github.com:edavidfs/dotfiles_linux.git
fi


if [[ $(command -v code) ]]
then
	echo "Instalando vscode"
	if [ $pkg_manager = "pacman" ]
	then
		sudo pacman -S --noconfirm code
	fi
fi


if [[ $(command -v feh) ]]
then
	echo "Instalando fondo de escritorio"
	if [ $pkg_manager = "pacman" ]
	then
		sudo pacman -S --noconfirm feh
		feh -bg-scale ~/.config/wallpapers/moon.jpg
	fi
fi

