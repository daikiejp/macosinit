#!/bin/bash

# Check if the wakatime config file exists
if [ -f "$config_folder/wakatime.cfg" ]; then
  # Copy the config file to the Desktop
  cp "$config_folder/wakatime.cfg" "$HOME/.wakatime.cfg"
  msg "The wakatime.cfg file has been copied."
else
  warning "The wakatime config file does not exist in the $config_folder directory. Skipping..."
fi

