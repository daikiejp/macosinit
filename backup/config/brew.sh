# !/bin/bash

# Check if Homebrew is installed
if command -v brew >/dev/null 2>&1; then
    # List all installed packages and redirect the output to the file
    brew list > "$config_folder/brew.txt"

    msg "List of installed Homebrew packages has been successfully exported to $config_folder/brew.txt"
else
    warning "Homebrew is not installed on this system. Skipping..."
fi

