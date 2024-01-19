#!/bin/bash

# Check if the .gitconfig file exists
if [ -f "$HOME/.gitconfig" ]; then
  # Create config git folder
  mkdir -p "$config_folder/git"
  # Copy the config file to the Desktop
  cp "$HOME/.gitconfig" "$config_folder/git/gitconfig"
  msg "The .gitconfig file has been copied. (It's not hidden)"
else
  warning "The .gitconfig file does not exist in the $HOME directory. Skipping..."
fi

# Check if the git configs file exists
if [ -d "$system_config_folder/git" ]; then
  # Create config git folder
  # mkdir -p "$config_folder/git"
  # Copy the git config files to the Desktop
  cp -R "$system_config_folder/git" "$config_folder"
  msg "The git config files has been copied."
else
  warning "The git config files does not exists in the $config_folder directory. Skipping..."
fi

