# macOS Init

## Modules

| Name       | Description            | Required |
| ---------- | ---------------------- | -------- |
| SSH        | Install SSH Keys       | Yes      |
| Homebrew   | Install Homebrew       | Yes      |
| GPG        | Install GPG Keys       | Optional |
| Wallpapers | Copy Wallpapers        | Optional |
| zshrc      | Copy zshrc config file | Yes      |

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
