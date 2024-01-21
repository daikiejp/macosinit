#!/bin/bash

# Function to delete all Fonts
delete_fonts() {
  # Confirm the deletion
  read -p "Are you sure you want to delete all Fonts? This action cannot be undone. (y/n): " confirmation

  if [ "$confirmation" != "y" ]; then
    warning "Aborted."
    return 1
  fi

  # Check if the Fonts directory exists
  if [ -d "$system_fonts_folder" ]; then
    # Delete all contents of the Fonts directory
    rm -rf "$system_fonts_folder"/*
    echo "All Fonts have been deleted."
  else
    echo "The Fonts directory does not exist. Skipping..."
  fi
}

# Call the function
delete_fonts

