# !/bin/bash

# Check if Homebrew is installed
if command -v brew >/dev/null 2>&1; then
    # List all installed packages and redirect the output to the file
    brew leaves -r > "$homebrew_packages"
    brew list --cask >> "$homebrew_packages"

    msg "List of installed Homebrew packages has been successfully exported to $homebrew_packages"
else
    warning "Homebrew is not installed on this system. Skipping..."
    # Create an empty file
    touch $homebrew_packages
fi

