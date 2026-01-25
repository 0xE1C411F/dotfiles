#!/bin/sh

NIXOS=false
GLOBAL_VARIABLES_FILE=global_variables.ini
CONFIG_FOLDER=$(echo ~/documents/projects/dotfiles)
RUN=true

while getopts "s:d" FLAG; do
  case "${FLAG}" in
    s)
      if [ "${OPTARG}" = "nixos" ]; then
        NIXOS=true
      fi
      ;;
    d)
      RUN=false
      ;;
  esac
done

substitute_variables_in_file() {
  cp $CONFIG_FOLDER/$1 $CONFIG_FOLDER/build/$1
  SUBSTITUTIONS=$(grep -Eo "\{\{([A-Z_0-9]*)\}\}" $CONFIG_FOLDER/build/$1 | wc -l)
  ITERATIONS=$SUBSTITUTIONS
  while [ $SUBSTITUTIONS -gt 0 ] && [ $ITERATIONS -gt 0 ]; do
    while IFS="" read -r LINE || [ -n "$LINE" ]; do
      if [ -n "$LINE" ]; then
        VARIABLE=$(echo $LINE | cut -d"=" -f1)
        VARIABLE="{{$VARIABLE}}"
        VALUE=$(echo $LINE | cut -d"=" -f2-)
        sed -i -e "s/$VARIABLE/$VALUE/g" $CONFIG_FOLDER/build/$1
      fi
    done < $CONFIG_FOLDER/build/$GLOBAL_VARIABLES_FILE
    SUBSTITUTIONS=$(grep -Eo "\{\{([A-Z_0-9]*)\}\}" $CONFIG_FOLDER/build/$1 | wc -l)
    ITERATIONS=$(($ITERATIONS - 1))
  done

  SUBSTITUTIONS=$(grep -Eo "\{\{([A-Z_0-9]*)\}\}" $CONFIG_FOLDER/build/$1 | wc -l)
  if [ $SUBSTITUTIONS -gt 0 ]; then
    echo "[ERROR] Circular references detected" 1>&2
    exit 109
  fi
}

substitute_variables() {
  if [ -d $1 ]; then
    echo "[INFO] Found directory $1"
    mkdir -p $CONFIG_FOLDER/build/$1
    for ENTRY in $1/*; do
      echo "[INFO]    - $ENTRY"
      substitute_variables $ENTRY
    done
  else
    substitute_variables_in_file $1
  fi
}

refresh_config() {
  substitute_variables $1
  if $RUN; then
    echo "[INFO] Replacing $2 with $1"
    rm -f $2
    ln -s $CONFIG_FOLDER/build/$1 $2
  fi
}

sudo_refresh_config() {
  substitute_variables $1
  if $RUN; then
    echo "[INFO] Replacing $2 with $1"
    sudo rm -f $2
    sudo ln -s $CONFIG_FOLDER/build/$1 $2
  fi
}

substitute_variables global_variables.ini
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
