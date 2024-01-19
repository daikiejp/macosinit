#!/bin/bash

# Function to delete wakatime configuration
delete_wakatime() {
  # Confirm the deletion
  read -p "Are you sure you want to delete wakatime configurations? This action cannot be undone. (y/n): " confirmation

  if [ "$confirmation" != "y" ]; then
    warning "Aborted."
    return 1
  fi

  # Check if the .wakatime.cfg file exists
  if [ -f "$HOME/.wakatime.cfg" ]; then
    # Delete the .wakatime.cfg file
    rm -f "$HOME/.wakatime.cfg"
    msg ".wakatime.cfg configuration has been deleted."
  else
    warning ".wakatime.cfg file does not exist. Skipping..."
  fi

  # Check if the wakatime directory exists
  if [ -d "$HOME/.wakatime" ]; then
    # Delete all contents of the .wakatime directory
    rm -rf "$HOME/.wakatime"
    # Delete all files starting with .wakatime
    rm -rf $HOME/.wakatime*
    msg "All wakatime folder and configurations have been deleted."
  else
    warning "The $HOME/.wakatime directory does not exist. Skipping..."
  fi
}

# Call the function
delete_wakatime
