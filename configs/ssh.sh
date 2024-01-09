# Install ssh into the system.

# Check if there are any files in the SSH folder
if [ -z "$(ls -A $ssh_folder)" ]; then
    warning "No SSH keys found in $ssh_folder"
else
    # Create the system SSH folder if it doesn't exist
    mkdir -p "$system_ssh_folder"

    # Import all SSH keys to GPG
    for ssh_key_file in $ssh_folder/*; do
        # Ensure correct permissions on the SSH public key file
        chmod 600 "$ssh_key_file"

        # Extract the SSH public key from the file
        ssh_public_key=$(ssh-keygen -y -f $ssh_key_file 2>&1)

        # Check if the key format is valid
        if [[ $ssh_public_key == *"invalid format"* ]]; then
            cp "$ssh_key_file" "$system_ssh_folder"
            msg "SSH keys from $ssh_key_file copied to $system_ssh_folder"

            # abort "Error: Invalid format for key file $ssh_key_file"
        else
            # Copy the SSH private key to the system SSH folder
            cp "$ssh_key_file" "$system_ssh_folder"
            # ssh-add "$ssh_key_file"

            msg "SSH keys from $ssh_key_file copied to $system_ssh_folder"
        fi 
    done
fi