# Install zshrc into the system.

# Check if there are any files in the $HOME folder
if [ -z "$(ls -A $config_folder/$zshrc_file)" ]; then
    abort "No zshrc file was found in $zshrc_file"
else
    # Copy the ZSHRC file to the system
    cp "$config_folder/$zshrc_file" "$HOME" && mv "$HOME/$zshrc_file" "$HOME/.$zshrc_file"
    msg "zshrc from "$config_folder/$zshrc_file" copied to $HOME"
fi

