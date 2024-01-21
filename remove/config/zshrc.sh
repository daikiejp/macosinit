#!/bin/bash

# Function to delete .zshrc configuration
delete_zshrc() {
  # Confirm the deletion
  read -p "Are you sure you want to delete .zshrc configurations? This action cannot be undone. (y/n): " confirmation

  if [ "$confirmation" != "y" ]; then
    warning "Aborted."
    return 1
  fi

  # Check if the .zshrc file exists
  if [ -f "$HOME/.zshrc" ]; then
    # Delete the .zshrc file
    rm -f "$HOME/.zshrc"
    msg ".zshrc configuration has been deleted."
  else
    warning ".zshrc file does not exist. Skipping..."
  fi
}

# Call the function
delete_zshrc

