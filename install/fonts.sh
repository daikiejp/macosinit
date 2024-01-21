# Check if the Fonts folder exists
if [ -z "$(ls -A $fonts_folder)" ]; then
    warning "fonts JSON file not found in $fonts_folder. Skipping..."
else
    # Create Fonts folder
    mkdir -p $system_fonts_folder

    # Copy Fonts
    cp -r "$fonts_folder"/* "$system_fonts_folder"
    msg "Fonts installed."
fi


