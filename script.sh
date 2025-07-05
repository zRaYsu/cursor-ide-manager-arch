#!/usr/bin/env bash

read -p "What do you want to do? (install/uninstall): " action
action=$(echo "$action" | tr '[:upper:]' '[:lower:]')

if [[ "$action" == "install" ]]; then
    read -p "How do you want to install Cursor IDE? (git/yay/pacman): " method
    method=$(echo "$method" | tr '[:upper:]' '[:lower:]')
    case "$method" in
        git)
            echo "Cloning Cursor IDE repository..."
            git clone https://github.com/getcursor/cursor.git ~/CursorIDE
            echo "Repository cloned to ~/CursorIDE. Follow the README instructions to install."
            ;;
        yay)
            if command -v yay >/dev/null 2>&1; then
                yay -S cursor
            else
                echo "yay is not installed. Please install yay first."
            fi
            ;;
        pacman)
            if command -v pacman >/dev/null 2>&1; then
                sudo pacman -S cursor
            else
                echo "pacman is not available."
            fi
            ;;
        *)
            echo "Unsupported installation method."
            ;;
    esac
elif [[ "$action" == "uninstall" ]]; then
    read -p "How did you install Cursor IDE? (git/yay/pacman): " method
    method=$(echo "$method" | tr '[:upper:]' '[:lower:]')
    case "$method" in
        git)
            echo "Removing cloned Cursor IDE folder..."
            rm -rf ~/CursorIDE
            ;;
        yay)
            if command -v yay >/dev/null 2>&1; then
                yay -Rns --noconfirm cursor || true
            fi
            ;;
        pacman)
            if command -v pacman >/dev/null 2>&1; then
                sudo pacman -Rns --noconfirm cursor || true
            fi
            ;;
        *)
            echo "Unsupported method. Proceeding with general cleanup."
            ;;
    esac
    rm -rf ~/.config/Cursor ~/.cache/Cursor ~/.local/share/Cursor
    rm -f ~/.local/share/applications/cursor.desktop
    rm -rf ~/.local/share/icons/hicolor/*/apps/cursor.png
    sudo rm -rf /opt/cursor

    sudo rm -rf /usr/share/applications/cursor.desktop
    sudo rm -rf /usr/local/bin/cursor
    sudo rm -rf /usr/bin/cursor
    echo "Cursor IDE has been removed."
else
    echo "Invalid option. Use 'install' or 'uninstall'."
fi

read -p "Do you want to try opening Cursor IDE to verify the action? (yes/no): " open_cursor
open_cursor=$(echo "$open_cursor" | tr '[:upper:]' '[:lower:]')

if [[ "$open_cursor" == "yes" || "$open_cursor" == "y" ]]; then
    echo "Attempting to open Cursor IDE..."
    
    if command -v cursor >/dev/null 2>&1; then
        echo "Found 'cursor' command, launching..."
        cursor &
    elif command -v code-cursor >/dev/null 2>&1; then
        echo "Found 'code-cursor' command, launching..."
        code-cursor &
    elif [ -f "/opt/cursor/cursor" ]; then
        echo "Found Cursor in /opt/cursor, launching..."
        /opt/cursor/cursor &
    elif [ -f "$HOME/.local/bin/cursor" ]; then
        echo "Found Cursor in ~/.local/bin, launching..."
        $HOME/.local/bin/cursor &
    elif [ -f "/usr/bin/cursor" ]; then
        echo "Found Cursor in /usr/bin, launching..."
        /usr/bin/cursor &
    else
        echo "Cursor IDE not found in common locations."
        echo "If it was supposed to be uninstalled, this is correct."
        echo "If it was supposed to be installed, there might be an issue."
    fi
    
    sleep 2
    echo "Check if Cursor IDE opened successfully."
else
    echo "Skipping Cursor IDE launch test."
fi
