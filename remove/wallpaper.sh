#!/bin/bash

# Function to delete all Wallpapers
delete_wallpaper() {
  # Confirm the deletion
  read -p "Are you sure you want to delete all Wallpapers? This action cannot be undone. (y/n): " confirmation

  if [ "$confirmation" != "y" ]; then
    warning "Aborted."
    return 1
  fi

  # Check if the Wallpaper directory exists
  if [ -d "$system_wallpapers_folder" ]; then
    # Delete all contents of the Wallpaper directory
    rm -rf "$system_wallpapers_folder"/*
    echo "All Wallpapers have been deleted."
  else
    echo "The Wallpaper directory does not exist. Skipping..."
  fi
}

# Call the function
delete_wallpaper

