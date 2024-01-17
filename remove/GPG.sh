#!/bin/bash

# Function to delete all GPG keys
delete_gpg_keys() {
  # Confirm the deletion
  read -p "Are you sure you want to delete all GPG keys? This action cannot be undone. (y/n): " confirmation

  if [ "$confirmation" != "y" ]; then
    warning "Aborted."
    return 1
  fi

  # List all secret keys and delete them one by one
  for key in $(gpg --list-secret-keys --with-colons | grep '^sec' | awk -F: '{print $5}'); do
    echo "Deleting secret key: $key"
    gpg --delete-secret-keys "$key"
  done

  # List all public keys and delete them one by one
  for key in $(gpg --list-keys --with-colons | grep '^pub' | awk -F: '{print $5}'); do
    echo "Deleting public key: $key"
    gpg --delete-keys "$key"
  done

  msg "All GPG keys have been deleted."
}

# Call the function
delete_gpg_keys
