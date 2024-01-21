# Check if the vimrc config file exists
if [ -f "$HOME/.vimrc" ]; then
  # Copy the config file to the Desktop
  cp "$HOME/.vimrc" "$config_folder/vimrc"
  msg "The vimrc file has been copied. (It's not hidden)"
else
  warning "The vimrc config file does not exist in the $HOME directory. Skipping..."
fi

