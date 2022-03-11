#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# Taken from https://github.com/michaeljsmalley/dotfiles/blob/dfda5948f2afe3d7d2c9087b04b56f8e4918abd0/makesymlinks.sh
############################

########## Variables

DIR=~/dotfiles                   # dotfiles directory
OLD_DIR=~/dotfiles_old             # old dotfiles backup directory
FILES="vimrc vim zshrc"           # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo -n "Creating $OLD_DIR for backup of any existing dotfiles in ~ ..."
mkdir -p $OLD_DIR
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $DIR directory ..."
cd $DIR
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $FILES
for file in $FILES; do
    echo "Moving any existing dotfiles from ~ to $OLD_DIR"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $DIR/.$file ~/.$file
done
