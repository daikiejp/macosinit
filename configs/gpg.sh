# Install GPG Keys

# Iterate over each key file in the folder
for key_file in "$gpg_folder"/*.asc; do
    # Check if there are any matching files
    if [ -e "$key_file" ]; then
        # Extract the key ID from the file
        key_id=$(gpg --with-colons --import-options show-only --import "$key_file" 2>/dev/null | awk -F: '$1=="pub"{print $5}')
        
        # Check if the key is already installed
        if gpg --list-keys "$key_id" &> /dev/null; then
            warning "Key $key_id is already installed."
        else
            # Import the GPG key and check the exit code
            gpg --import "$key_file" &>/dev/null
            import_exit_code=$?

            # Check if the import was successful
            if [ $import_exit_code -eq 0 ]; then
                msg "Key $key_id has been successfully imported."
                
                # Optionally, you can also delete the key file after importing
                # rm "$key_file"
            else
                abort "Error: Failed to import key from $key_file."
            fi
        fi
    else
        warning "No GPG key files found in the specified folder."
    fi
done

