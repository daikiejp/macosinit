# macOS Init

## Modules

| Name         | Description                     | Required | macOSInit |
| ------------ | ------------------------------- | -------- | --------- |
| SSH          | Install SSH Keys                | Yes      | Supported |
| GPG          | Install GPG Keys                | Optional | Supported |
| gitconfig    | Git config and workspace        | Yes      | Supported |
| Homebrew     | Install Homebrew and apps       | Yes      | Supported |
| Power10k     | Install Oh My Zsh and Power 10k | Yes      | Supported |
| zshrc        | Copy zshrc config file          | Yes      | Supported |
| wakatime.cfg | Wakatime Config                 | Optional | Supported |
| Wallpapers   | Copy Wallpapers                 | Optional | Supported |
| Fonts        | Copy Wallpapers                 | Yes      | Supported |
| scripts      | Custom scripts and aliases      | Optional | Manually  |
| vimrc        | Copy vimrc config file          | Yes      | Supported |
| vscode       | Extensions, Theme and Config    | Yes      | Manually  |
| Emails       | Profile Config                  | Optional | Manually  |

## Requirements

You need a folder called "macosinit" on the Desktop with your personal backup files such as SSH keys, configs, wallpapers, etc. Or you can use the script to make a backup before: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/daikiejp/macosinit/master/backup.sh)"`

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

### Post-install script (examples)

- Obsidian

### Visual Studio Code Configurations

For VS Code, it is not possible to automatically install personal settings. However, I have created two VSCode profiles that suit my own needs: one environment for JavaScript and another environment for Data Science.

Please use my settings and configure them according to your needs.

You need import Profile from VS Code and the paste the following URLs:

For JavaScript: `https://tools.daikie.jp/vscode`  
For Data Science: `https://tools.daikie.jp/datascience`

### List of manual installations/configurations

- Drivers (Printer, Scanner, Android USB Tools)
- Organize Apps Folder
- Organize macOS Dock
- macOS Preferences

### Others configuration

For more information or more configurations visit https://tools.daikie.jp/

## Author

Danny Davila (@daikiejp) - だいきえ  
2024
