#!/bin/bash

# Check if Homebrew is installed
if command -v brew >/dev/null 2>&1; then
    # Get a list of all installed packages
    installed_packages=$(brew leaves -r && brew list --cask)

    # Uninstall each package
    for package in $installed_packages; do
        echo "Uninstalling $package..."
        brew uninstall --force "$package"
    done

    msg "All Homebrew packages have been uninstalled."

    echo "Uninstalling Homebrew..."

    # Uninstall Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

    # Remove any remaining Homebrew directories
    # echo "Removing remaining Homebrew directories..."
    sudo rm -rf /usr/local/Homebrew
    sudo rm -rf /opt/homebrew
    sudo rm -rf /usr/local/Caskroom
    sudo rm -rf /usr/local/Cellar
    sudo rm -rf /usr/local/bin/brew

    # Remove any references in the shell profile
    # echo "Removing Homebrew references from shell profile files..."
    sed -i '' '/# Homebrew/d' ~/.bash_profile
    sed -i '' '/# Homebrew/d' ~/.zshrc
    sed -i '' '/export PATH=\/usr\/local\/bin:\$PATH/d' ~/.bash_profile
    sed -i '' '/export PATH=\/opt\/homebrew\/bin:\$PATH/d' ~/.zshrc

    msg "Homebrew and all its packages have been successfully uninstalled."
else
    warning "Homebrew is not installed on this system. Skipping..."
fi

