#!/bin/sh

NIXOS=false

while getopts "s:" flag; do
  case "${flag}" in
    s)
      if [ "${OPTARG}" = "nixos" ]; then
        NIXOS=true
      fi
      ;;
  esac
done


refresh_config() {
  rm -f $2
  ln -s ~/documents/projects/dotfiles/$1 $2
}

sudo_refresh_config() {
  sudo rm -f $2
  sudo ln -s ~/documents/projects/dotfiles/$1 $2
}

refresh_config airline_e1c411f.vim ~/.config/nvim/autoload/airline/themes/e1c411f.vim
refresh_config coc-settings.json ~/.config/nvim/coc-settings.json
refresh_config e1c411f.vim ~/.config/nvim/colors/e1c411f.vim
refresh_config init.lua ~/.config/nvim/init.lua
refresh_config syntax_cpp.vim ~/.config/nvim/after/syntax/cpp.vim
refresh_config vimrc ~/.vimrc
if $NIXOS; then
  refresh_config sway.config ~/.config/sway/config
  refresh_config waybar.jsonc ~/.config/waybar/config.jsonc
  refresh_config waybar.css ~/.config/waybar/style.css
  refresh_config terminal.ini ~/.config/foot/foot.ini
  refresh_config waybar_scripts ~/.config/waybar/scripts
  sudo_refresh_config configuration.nix /etc/nixos/configuration.nix
  sudo nixos-rebuild switch
fi
