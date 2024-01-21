# Check if the wakatime config file exists
if [ -f "$HOME/.wakatime.cfg" ]; then
  # Copy the config file to the Desktop
  cp "$HOME/.wakatime.cfg" "$config_folder/wakatime.cfg"
  msg "The wakatime.cfg file has been copied. (It's not hidden)"
else
  warning "The wakatime config file does not exist in the $HOME directory. Skipping..."
fi

