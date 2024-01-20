# macOS Init

## Modules

| Name         | Description                  | Required | macOSInit |
| ------------ | ---------------------------- | -------- | --------- |
| SSH          | Install SSH Keys             | Yes      | Supported |
| Homebrew     | Install Homebrew and apps    | Yes      | Supported |
| GPG          | Install GPG Keys             | Optional | Supported |
| Wallpapers   | Copy Wallpapers              | Optional | Supported |
| Fonts        | Copy Wallpapers              | Yes      | Supported |
| zshrc        | Copy zshrc config file       | Yes      | Supported |
| scripts      | Custom scripts and aliases   | Optional | Manually  |
| vimrc        | Copy vimrc config file       | Yes      | Supported |
| gitconfig    | Git config and workspace     | Yes      | Supported |
| vscode       | Extensions, Theme and Config | Yes      | Manually  |
| wakatime.cfg | Wakatime Config              | Optional | Supported |
| Emails       | Profile Config               | Optional | Manually  |

## TODO

- Docker Data
- Preferences

## Usage

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/daikiejp/macosinit/master/install.sh)"
```

## Build

Config by editing your own preferences on folders `preferences` and build with

```bash
node build/backup.js
node build/install.js
node build/remove.js
```

then, execute:

```bash
bash install.sh
```

on a new Machine

**Note** .zshrc is not backup, check manually before formatting.

## Manual installation

### macOS Profile (profile.mobileconfig)

Some configurations need to be installed manually due to security or macOS limitations. However, there are one-click installation solutions available through Apple Configurator settings, which can configure: Email, WiFi, Fonts, Calendar. (Fonts are installed with macosInit scripts due to the file size.)

I am personally using it only for **Email configurations**.

### Post-install script

- Obsidian

### List of manual installations

- Drivers

## Author

Danny Davila (@daikiejp) - だいきえ  
2024
