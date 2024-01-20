# Check if the Wallpapers folder exists
if [ -z "$(ls -A $wallpapers_folder)" ]; then
    warning "Wallpapers JSON file not found in $wallpapers_folder. Skipping..."
else
    # Create Wallpaper folder
    mkdir -p $system_wallpapers_folder

    # Copy Wallpapers
    cp "$wallpapers_folder"/* "$system_wallpapers_folder"
    msg "Wallpapers installed."
fi

