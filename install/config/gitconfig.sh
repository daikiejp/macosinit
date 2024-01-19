#!/bin/bash

# Check if the .gitconfig file exists
if [ -f "$config_folder/git/gitconfig" ]; then
  # Create config git folder
  # mkdir -p "$config_folder/git"
  # Copy the config file to the Desktop
  cp "$config_folder/git/gitconfig" "$HOME/.gitconfig"
  msg "The .gitconfig file has been copied."
else
  warning "The .gitconfig file does not exist in the $config_folder directory. Skipping..."
fi

# Function to copy files excluding gitconfig
copy_git_configs() {
  local src_dir=$1
  local dest_dir=$2
  mkdir -p "$dest_dir"
  for file in "$src_dir"/*; do
    base_name=$(basename "$file")
    if [[ -f $file && "$base_name" != "gitconfig" ]]; then
      cp "$file" "$dest_dir"
    fi
  done
}

# Check if the git configs directory exists
if [ -d "$config_folder/git" ]; then
  # Create config git folder
  mkdir -p "$config_folder/git"
  # Copy the git config files to the $HOME/config/git, excluding gitconfig
  copy_git_configs "$config_folder/git" "$system_config_folder/git"
  msg "The git config files have been copied, excluding gitconfig."
else
  warning "The git config directory does not exist in the $config_folder directory. Skipping..."
fi
