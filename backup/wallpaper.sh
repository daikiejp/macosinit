# Copy all Wallpapers
if [ -d "$system_wallpapers_folder" ]; then
  # Create Wallpaper folder
  mkdir -p "$wallpapers_folder"
  # Copy Wallpapers
  cp -r "$system_wallpapers_folder"/* "$wallpapers_folder"
  msg "Wallpapers have been copied to '$wallpapers_folder'." 
else
  warning "Wallpaper directory does not exist, skipping..."
fi

