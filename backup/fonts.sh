# Copy all Fonts
if [ -d "$system_fonts_folder" ]; then
  # Create Fonts folder
  mkdir -p "$fonts_folder"
  # Copy fonts
  cp -r "$system_fonts_folder"/* "$fonts_folder"
  msg "fonts have been copied to '$fonts_folder'." 
else
  warning "Fonts directory does not exist, skipping..."
fi
