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
 	if [[ -f /etc/debian_version ]]
	then
		echo "Instalando para debian"
		pkg_manager=apt
	fi
fi

echo "Instalando git"
if [ $pkg_manager = "pacman" ]
then
	sudo pacman -S --noconfirm git
fi

if [[ $(command -v nvim) ]]
then
	echo "NeoVim ya esta instalado"
else
	echo "Instalando NeoVim + clipboard"
	if [ $pkg_manager = "pacman" ]
	then
		sudo pacman -S --noconfirm neovim xclip
	fi

	if [ $pkg_manager = "apt" ]
	then
		sudo apt install -y neovim xclip
	fi
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
	if [ $pkg_manager = "apt" ]
	then
		sudo apt install -y rofi
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
	if [ $pkg_manager = "apt" ]
	then
		sudo apt install -y zsh
	fi
fi
 
if [[ $(command -v paru) ]]
then
	echo "Paru ya esta instalado"
else
	if [ $pkg_manager = "pacman" ]
	then
		git clone https://aur.archlinux.org/paru-bin.git
		cd paru-bin
		makepkg -si
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

	if [ $pkg_manager = "apt" ]
	then
		curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
		echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
		sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
		curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
		sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
		curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
		sudo apt update && sudo apt install -y 1password

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

if [[ $(command -v tailscaled) ]]
then
	echo "TailScales ya esta instalado"
else
	sudo pacman -S tailscale
	sudo systemctl enable --now tailscaled
	sudo tailscale up
fi

if [[ $(command -v sshd) ]]
then
	echo "Openssh ya esta instalado"
else
	if [ $pkg_manager = "apt" ]
	then
		sudo apt install -y openssh-server
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

