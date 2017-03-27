#!/bin/bash

ln -s "${PWD}/vimrc" "${HOME}/.vimrc"
mkdir "${HOME}/.vim"

git clone "https://github.com/VundleVim/Vundle.vim.git" "${HOME}/.vim/bundle/Vundle.vim"

vim +PluginInstall
vim +PluginUpdate

echo "Done."
