# Install own custom scripts

# Check if there are any files in the scripts folder
if [ -z "$(ls -A $scripts_folder)" ]; then
    warning "No scripts found in $scripts_folder"
else
    if [ -z "$(ls -A $aliases_file)" ]; then
        warning "No aliases found in $scripts_folder"
    else
        # Copy aliases file into config folder (temp)
        cp "$aliases_file" "$system_config_folder"

        # Create the system scripts folder if it doesn't exist
        mkdir -p "$system_scripts"

        # Import all scripts files
        for scripts_file in $scripts_folder/*; do

        # Copy the scripts files to the system scripts folder
        cp "$scripts_file" "$system_scripts"

        msg "Scripts from $scripts_file copied to $system_scripts" 
        done
        
        # Check if the file exists
        if [[ -f "$aliases_system_file" ]]; then
            # Use sed to replace the line
            sed -i '' 's|SCRIPT_DIR="scripts"|SCRIPT_DIR="$HOME/.config/scripts"|' "$aliases_system_file"
            msg "The line SCRIPT_DIR has been successfully replaced in $aliases_system_file."
        else
            warning "The file $aliases_system_file does not exist."
        fi

        # Add permissions to aliases file
        chmod +x "$aliases_system_file"

        # Execute aliases script
        /bin/bash -c "$aliases_system_file"
    fi
fi