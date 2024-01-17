#!/bin/bash

# Function to delete all SSH keys and configurations
delete_ssh_keys() {
  # Confirm the deletion
  read -p "Are you sure you want to delete all SSH keys and configurations? This action cannot be undone. (y/n): " confirmation

  if [ "$confirmation" != "y" ]; then
    warning "Aborted."
    return 1
  fi

  # Check if the .ssh directory exists
  if [ -d "$system_ssh_folder" ]; then
    # Delete all contents of the .ssh directory
    rm -rf "$system_ssh_folder"/*
    echo "All SSH keys and configurations have been deleted."
  else
    echo "The .ssh directory does not exist. Skipping..."
  fi
}

# Call the function
delete_ssh_keys
