#!/bin/sh

rm ~/Library/Application\ Support/Code/User/settings.json
ln -s ~/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

# include keybindings.json
#rm ~/Library/Application\ Support/Code/User/keybindings.json
#ln -s ~/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
