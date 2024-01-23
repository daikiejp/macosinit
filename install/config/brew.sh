#!/bin/bash

# Check if the input file exists
if [[ ! -f "$homebrew_packages" ]]; then
    warning "Error: File '$homebrew_packages' not found."
fi

# Check if Homebrew is already installed
if ! command -v brew >/dev/null 2>&1; then
    echo "Installing Homebrew..."



    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # After Homebrew installation
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    source ~/.zprofile

    # Verify installation
    if command -v brew >/dev/null 2>&1; then
        msg "Homebrew installed successfully."
    else
        abort "Failed to install Homebrew."
    fi
else
    warning "Homebrew is already installed. Skipping..."
fi

# Update Homebrew to ensure the latest package versions
echo "Updating Homebrew..."
brew update

# Read package names from the file and install them
xargs brew install < $homebrew_packages

msg "All packages from $homebrew_packages have been processed."

