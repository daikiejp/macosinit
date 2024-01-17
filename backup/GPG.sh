# Export public keys
if ! gpg --list-keys > /dev/null 2>&1; then
  warning "No GPG public keys found to export."
else
  gpg --export --armor > "$gpg_folder/public_keys.asc"
  #msg "Public keys exported to $gpg_folder/public_keys.asc"
fi

# Export private keys
if ! gpg --list-secret-keys > /dev/null 2>&1; then
  warning "No GPG private keys found to export."
else
  gpg --export-secret-keys --armor > "$gpg_folder/private_keys.asc"
  #msg "Private keys exported to $gpg_folder/private_keys.asc"
fi

# Export ownertrust
gpg --export-ownertrust > "$gpg_folder/ownertrust.txt"
#msg "Ownertrust exported to $gpg_folder/ownertrust.txt"

msg "GPG keys have been exported to '$gpg_folder'."