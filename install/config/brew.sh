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
while read -r formula; do  
  # Install Homebrew packages
  if brew install "$formula"; then
    msg "$formula installed successfully."
  else
    echo "Error installing $formula. Continuing with the next package..."
  fi
  
  echo
done < "$homebrew_packages"

msg "All packages from $homebrew_packages have been processed."

