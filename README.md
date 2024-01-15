# macOS Init

## Modules

| Name         | Description                  | Required |
| ------------ | ---------------------------- | -------- |
| SSH          | Install SSH Keys             | Yes      |
| Homebrew     | Install Homebrew and apps    | Yes      |
| GPG          | Install GPG Keys             | Optional |
| Wallpapers   | Copy Wallpapers              | Optional |
| zshrc        | Copy zshrc config file       | Yes      |
| vimrc        | Copy vimrc config file       | Yes      |
| gitconfig    | Git config and workspace     | Yes      |
| scripts      | Custom scripts               | Optional |
| vscode       | Extensions, Theme and Config | Yes      |
| wakatime.cfg | Wakatime Config              | Optional |

## TODO

- Docker Data
- Arc/Brave Import
- Preferences

## Usage

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/daikiejp/macosinit/master/install.sh)"
```

## Build

Config by editing your own preferences on folders `preferences` and build with

```bash
node build.js
```

then, execute:

```bash
bash install.sh
```

on a new Machine
