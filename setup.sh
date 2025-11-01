#!/bin/sh

refresh_config() {
  rm -f $2
  ln -s ~/dotfiles/$1 $2
}

refresh_config airline_e1c411f.vim ~/.config/nvim/autoload/airline/themes/e1c411f.vim
refresh_config coc-settings.json ~/.config/nvim/coc-settings.json
refresh_config e1c411f.vim ~/.config/nvim/colors/e1c411f.vim
refresh_config init.lua ~/.config/nvim/init.lua
refresh_config syntax_cpp.vim ~/.config/nvim/after/syntax/cpp.vim
refresh_config vimrc ~/.vimrc
