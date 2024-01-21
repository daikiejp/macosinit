# Check if the .ssh/config file exists
if [ -f "$system_ssh_folder/config" ]; then
  # Create config SSH folder
  mkdir -p "$config_folder/ssh"
  # Copy the config file to the Desktop
  cp "$system_ssh_folder/config" "$config_folder/ssh/config"
  msg "The config file has been copied to the Desktop."
else
  warning "The SSH config file does not exist in the .ssh directory."
fi
