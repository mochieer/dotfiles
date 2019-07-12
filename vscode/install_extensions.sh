#!/bin/sh

# install code cli
# https://code.visualstudio.com/docs/setup/mac
cat ~/dotfiles/vscode/extensions | while read line
do
  code --install-extension $line
done
