# Install ssh config into the system.

# Check if there are any files in the SSH folder
if [ -z "$(ls -A $config_folder/ssh/config)" ]; then
    warning "No SSH config found in $ssh_folder. Skipping..."
else
    # Copy the config file to the Desktop
    cp "$config_folder/ssh/config" "$system_ssh_folder/config"
    msg "The SSH config file has been copied."
fi

