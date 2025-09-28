# Cross-Platform Dotfiles

This repository contains personalized dotfiles and configuration for macOS, NixOS, Linux, and Windows environments.

## Structure Overview

- **common/**: Cross-platform shared configs and scripts (fish shell, nvim, etc.)  
- **dotfiles/**: Root-level personal dotfiles (shell configs, gitconfig, aliases)  
- **macos/**: macOS specific configs, Homebrew Brewfile, nix-darwin flake, launch agents  
- **nixos/**: NixOS configuration including system configs, modules, and hardware setups  
- **windows/**: PowerShell profiles, scripts, and Windows-specific configs  
- **vscode/**: VSCode extensions and settings  
- **docs/**: Documentation and notes  
- **keys/**: Public GPG keys (never store private keys here)  
- **scripts/**: Cross-platform bootstrap and utility scripts  

## Getting Started

Clone this repository:

```
git clone git@github.com:exampleuser/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

## Setup

Run the setup script appropriate for your platform:

- On **macOS**:

  ```
  ./macos/scripts/setup.sh
  ```

- On **NixOS/Linux**:

  ```
  ./nixos/scripts/setup.sh
  ```

- On **Windows** (PowerShell):

  ```
  ./windows/powershell/setup.ps1
  ```

## Git Configuration

Ensure your Git identity is set for proper commit attribution:

```
git config --global user.name "YourName"
git config --global user.email "youremail@example.com"
```

## Features

- Modular and maintainable configuration for multiple OSes  
- Declarative NixOS and nix-darwin configurations for reproducible environments  
- Shared fish shell functions and configs  
- PowerShell profiles and scripts for Windows automation  
- VSCode extensions and settings to unify editor config  
- Backup and restore scripts to safeguard your setup  

## Contributing

This repository is personal but open for forks and modifications.  
Feel free to raise issues or submit pull requests for improvements.

## Security

- **Do not commit private keys** to this repository; only add public keys in `keys/`.  
- Manage secrets securely outside this repo, e.g., environment variables or secret managers.

## License

This dotfiles repository is provided as-is for personal use.

---

Happy coding!
