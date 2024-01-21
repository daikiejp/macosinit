# Function to copy files and remove leading dot
copy_and_rename() {
  local src_dir=$1
  local dest_dir=$2
  for file in "$src_dir"/*; do
    if [[ -f $file ]]; then
      base_name=$(basename "$file")
      # Exclude the config file from being copied
      if [[ "$base_name" != "config" ]]; then
        new_name="${base_name#.}"
        cp "$file" "$dest_dir/$new_name"
      fi
    fi
  done
}

# Copy SSH files and remove leading dot from filenames
if [ -d "$system_ssh_folder" ]; then
  copy_and_rename "$system_ssh_folder" "$ssh_folder"
  msg "SSH files have been copied to '$ssh_folder' and renamed." 
else
  warning "SSH directory does not exist, skipping..."
fi

