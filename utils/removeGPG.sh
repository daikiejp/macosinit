#!/bin/bash

# Confirm the deletion
read -p "Are you sure you want to delete all GPG keys? This action cannot be undone. (yes/no): " confirmation

if [ "$confirmation" != "yes" ]; then
  echo "Aborted."
  exit 1
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

echo "All GPG keys have been deleted."
