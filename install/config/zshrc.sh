#!/bin/bash

# Define the line to be added
comment_line='# GPG Issue'
line_to_add='export GPG_TTY=$TTY'

# Define the .zshrc file path
zshrc_file="$HOME/.zshrc"

# Check if the .zshrc file exists, if not create it
if [ ! -f "$zshrc_file" ]; then
  touch "$zshrc_file"
  msg "Created $zshrc_file as it did not exist."
fi

# Check if the line already exists in .zshrc
if grep -Fxq "$comment_line" "$zshrc_file" && grep -Fxq "$line_to_add" "$zshrc_file"; then

  warning "The line '$line_to_add' already exists in $zshrc_file. No changes made."
else
  # Add the line at the beginning of .zshrc
  {
    echo "$comment_line"
    echo "$line_to_add"
    echo ""
    cat "$zshrc_file"
  } > "$zshrc_file.tmp" && mv "$zshrc_file.tmp" "$zshrc_file"

  msg ".zshrc file is created and added GPG_TTY"
fi
