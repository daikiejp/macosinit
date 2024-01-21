#!/bin/bash

# Function to delete vimrc configuration
delete_vimrc() {
  # Confirm the deletion
  read -p "Are you sure you want to delete vimrc configurations? This action cannot be undone. (y/n): " confirmation

  if [ "$confirmation" != "y" ]; then
    warning "Aborted."
    return 1
  fi

  # Check if the .vimrc file exists
  if [ -f "$HOME/.vimrc" ]; then
    # Delete the .vimrc.cfg file
    rm -f "$HOME/.vimrc"
    msg ".vimrc configuration has been deleted."
  else
    warning ".vimrc file does not exist. Skipping..."
  fi

  # Check if the vimrc directory exists
  # if [ -d "$HOME/.vim" ]; then
  #   # Delete all contents of the .vimrc directory
  #   rm -rf "$HOME/.vim"
  #   # Delete all files starting with .vimrc
  #   rm -rf $HOME/.vim*
  #   msg "All vimrc folder and configurations have been deleted."
  # else
  #   warning "The $HOME/.vimrc directory does not exist. Skipping..."
  # fi
}

# Call the function
delete_vimrc

