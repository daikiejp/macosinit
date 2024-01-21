#!/bin/bash

# Check if the vimrc config file exists
if [ -f "$config_folder/vimrc" ]; then
  # Copy the config file to the Desktop
  cp "$config_folder/vimrc" "$HOME/.vimrc"
  msg "The vimrc file has been copied."
else
  warning "The vimrc config file does not exist in the $config_folder directory. Skipping..."
fi

