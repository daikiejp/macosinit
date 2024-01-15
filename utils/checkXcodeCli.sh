# Verify if the Xcode Command Line Tools is installed
if command -v xcode-select >/dev/null 2>&1; then
    msg "Xcode Command Line Tools is already installed."
else
    # Install xcode-select if not installed
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install
fi

