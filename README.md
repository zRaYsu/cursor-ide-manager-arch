# Cursor IDE Manager for Arch Linux

A simple bash script to install or uninstall Cursor IDE on Arch Linux with Wayland support.

## Features

- Interactive installation and uninstallation
- Multiple installation methods support:
  - Git clone
  - YAY (AUR helper)
  - Pacman
- Comprehensive cleanup during uninstallation
- Verification by attempting to launch Cursor IDE after operations
- Wayland environment compatible

## Usage

1. Make the script executable:
```bash
chmod +x script.sh
```

2. Run the script:
```bash
./script.sh
```

3. Follow the interactive prompts:
   - Choose to install or uninstall
   - Select installation/uninstallation method
   - Optionally test if Cursor IDE opens after the operation

## Installation Methods

### Git Clone
Downloads the Cursor IDE repository to `~/CursorIDE`. You'll need to follow the README instructions in the cloned repository to complete the installation.

### YAY (AUR Helper)
Installs Cursor IDE using the AUR helper `yay`. Make sure you have `yay` installed on your system.

### Pacman
Attempts to install Cursor IDE using the official package manager (if available in official repositories).

## Uninstallation

The script performs comprehensive cleanup including:
- Package removal (based on installation method)
- Configuration files (`~/.config/Cursor`)
- Cache files (`~/.cache/Cursor`)
- User data (`~/.local/share/Cursor`)
- Desktop entries and icons
- System-wide installations (`/opt/cursor`, `/usr/bin/cursor`, etc.)

## Requirements

- Arch Linux
- Bash shell
- sudo privileges (for some operations)

## License

This project is open source and available under the [MIT License](LICENSE).

## Contributing

Feel free to submit issues, fork the repository, and create pull requests for any improvements.
