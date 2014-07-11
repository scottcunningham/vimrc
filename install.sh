#!/bin/bash

DOTFILES="vimrc vim"

for fn in $DOTFILES; do
	echo "Copying $fn"
	ln -s $PWD/$fn $HOME/.$fn 
done

echo "Done."
