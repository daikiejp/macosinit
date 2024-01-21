#!/bin/bash

# Function to delete all git configurations
delete_gitconfig() {
  # Confirm the deletion
  read -p "Are you sure you want to delete all gitconfig preferences configurations? This action cannot be undone. (y/n): " confirmation

  if [ "$confirmation" != "y" ]; then
    warning "Aborted."
    return 1
  fi

  # Check if the .gitconfig file exists
  if [ -f "$HOME/.gitconfig" ]; then
    # Delete the .gitconfig file
    rm -f "$HOME/.gitconfig"
    msg ".gitconfig configuration has been deleted."
  else
    warning ".gitconfig file does not exist. Skipping..."
  fi

  # Check if the gitconfig folder directory exists
  if [ -d "$system_config_folder/git" ]; then
    # Delete all contents of the .ssh directory
    rm -rf "$system_config_folder/git"
    msg "All gitconfig configurations have been deleted."
  else
    warning "The $system_config_folder/git directory does not exist. Skipping..."
  fi
}

# Call the function
delete_gitconfig

