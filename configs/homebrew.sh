# Check if Homebrew is installed
if command -v brew &> /dev/null; then
    msg "Homebrew is already installed."
else
    # Install Homebrew if not installed
    warning "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo "# Set PATH, MANPATH, etc., for Homebrew."; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Check if the external file exists
if [ ! -f $homebrew_packages ]; then
    warning "No Homebrew packages file found."
else
    # Read package names from the file and install them
    echo "Installing packages from $homebrew_packages..."
    while IFS= read -r package || [[ -n "$package" ]]; do
    # Skip empty lines and comments
    if [[ -z "$package" || "$package" == \#* ]]; then
        continue
    fi

    echo "Installing $package..."
    brew install "$package"

    # Check if the package was installed successfully
    if brew list --formula | grep -q "^$package\$"; then
        echo "$package installed successfully."
    else
        echo "Failed to install $package."
    fi
    done < $homebrew_packages

    msg "Homebrew packages installation complete."
fi

