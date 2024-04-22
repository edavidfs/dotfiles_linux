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
	echo "Rofi ya esta instalado"
else
	echo "Instalando Rofi"
	if [ $pkg_manager = "pacman" ]
	then
		sudo pacman -S --noconfirm rofi
	fi
fi


if [[ $(command -v zsh) ]]
then
	echo "ZSH ya esta instalado"
else
	echo "Instalando ZSH y ZIM"
	if [ $pkg_manager = "pacman" ]
	then
		sudo pacman -S --noconfirm zsh
		#chsh -s $(which zsh)

	#	curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
	#	zimfw install

	fi
fi

if [[ $(command -v 1password) ]]
then
	echo "1Password instalado"
else
	if [ $pkg_manager = "pacman" ]
	then
		echo "Instalando 1Password"
		curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import
		git clone https://aur.archlinux.org/1password.git
		cd 1password
		makepkg -si
	fi
fi



if [[ $(command -v kitty) ]]
then
	echo "Kitty Instalado"
else
	echo "Instalando Kitty"
	if [ $pkg_manager = "pacman" ]
	then
		sudo pacman -S --noconfirm kitty 
		THEME=https://raw.githubusercontent.com/dexpota/kitty-themes/master/themes/Espresso.conf
		wget "$THEME" -P ~/.config/kitty/kitty-themes/themes
		rm ~/.config/kitty/theme.conf
		cd ~/.config/kitty && ln -s ./kitty-themes/themes/Espresso.conf ~/.config/kitty/theme.conf
	fi
fi


if [[ $(command -v yadm) ]]
then
	echo "YADM ya esta instalado"
else
	echo "Instalando YADM"
	if [ $pkg_manager = "pacman" ]
	then
		#sudo pacman -S --noconfirm yadm
		#yadm clone git@github.com:edavidfs/dotfiles_linux.git
		echo "No he instalado yadm"
	fi
fi


if [[ $(command -v code) ]]
then
	echo "Visual Studio Code ya esta instalado"
else
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

