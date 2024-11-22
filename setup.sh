#!/bin/bash

# Colors for better visibility
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Error handling function
error_exit() {
    echo -e "${RED}Error: $1${NC}" >&2
    exit 1
}

# Success message function
success_msg() {
    echo -e "${GREEN}$1${NC}"
}

# Warning message function
warning_msg() {
    echo -e "${YELLOW}$1${NC}"
}

# Check if running on Arch Linux
if ! command -v pacman &> /dev/null; then
    error_exit "This script is designed for Arch Linux. Please use the appropriate package manager for your distribution."
fi

# Create backup directory
BACKUP_DIR="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
success_msg "Created backup directory: $BACKUP_DIR"

# Backup existing configurations
for file in .fehbg .profile .xinitrc .zshrc; do
    if [ -f "$HOME/$file" ]; then
        cp "$HOME/$file" "$BACKUP_DIR/"
        warning_msg "Backed up existing $file"
    fi
done

# Check if git is installed, if not, install it
if ! command -v git &> /dev/null; then
    warning_msg "Git not found. Installing Git..."
    sudo pacman -S --needed --noconfirm git || error_exit "Failed to install git"
else
    success_msg "Git is already installed."
fi

# Check for essential build dependencies
if ! pacman -Qi base-devel >/dev/null 2>&1; then
    warning_msg "Installing base-devel..."
    sudo pacman -S --needed --noconfirm base-devel || error_exit "Failed to install base-devel"
fi

# Check if destination directory exists
if [ -d "$HOME/.my_dwm" ]; then
    error_exit "Directory $HOME/.my_dwm already exists. Please remove or backup manually."
fi

# Clone the repository
echo "Cloning Git repo..."
git clone https://github.com/F1PWE/.suckless.git $HOME/.my_dwm || error_exit "Failed to clone repository"
success_msg "Repository cloned successfully"

# Verify required directories exist
for dir in "dotfiles" "scripts" "backgrounds"; do
    if [ ! -d "$HOME/.my_dwm/$dir" ]; then
        error_exit "$dir directory not found in the repository. Please check the repo structure."
    fi
done

# Install required packages from requirements.txt
if [ -f $HOME/.my_dwm/requirements.txt ]; then
    warning_msg "Installing required packages from requirements.txt..."
    sudo pacman -S --needed --noconfirm $(cat $HOME/.my_dwm/requirements.txt | xargs) || error_exit "Failed to install required packages"
    success_msg "Required packages installed successfully"
else
    warning_msg "requirements.txt not found. Skipping package installation."
fi

# Create necessary directories
mkdir -p $HOME/.local/bin
mkdir -p $HOME/.local/share

# Extract dotfiles to home (including hidden files)
warning_msg "Extracting dotfiles to home..."
shopt -s dotglob
cp -r $HOME/.my_dwm/dotfiles/* $HOME/ || error_exit "Failed to copy dotfiles"
shopt -u dotglob
success_msg "Dotfiles extracted successfully"

# Extract scripts to .local/bin
warning_msg "Extracting scripts to .local/bin..."
cp -r $HOME/.my_dwm/scripts/* $HOME/.local/bin/ || error_exit "Failed to copy scripts"
chmod +x $HOME/.local/bin/* # Make scripts executable
success_msg "Scripts extracted successfully"

# Move backgrounds folder
warning_msg "Moving backgrounds folder..."
cp -r $HOME/.my_dwm/backgrounds $HOME/ || error_exit "Failed to copy backgrounds"
success_msg "Backgrounds copied successfully"

# Source .profile
warning_msg "Sourcing .profile..."
source $HOME/.profile

# Compile and install suckless tools
warning_msg "Compiling dwm and related programs..."
for program in dwm st slstatus dmenu; do
    cd $HOME/.my_dwm/.suckless/$program || error_exit "Failed to enter $program directory"
    make clean
    make || error_exit "Failed to compile $program"
    sudo make PREFIX=$HOME/.local/ install || error_exit "Failed to install $program"
    success_msg "$program compiled and installed successfully"
done

# Create or update .xinitrc if it doesn't contain dwm
if ! grep -q "exec dwm" "$HOME/.xinitrc" 2>/dev/null; then
    echo "exec dwm" >> "$HOME/.xinitrc"
fi

# Check for xorg
if ! pacman -Qi xorg-server >/dev/null 2>&1; then
    warning_msg "Installing xorg-server..."
    sudo pacman -S --needed --noconfirm xorg-server xorg-xinit || error_exit "Failed to install xorg"
fi

# Check for zsh and oh-my-zsh
if ! command -v zsh &> /dev/null; then
    warning_msg "Installing zsh..."
    sudo pacman -S --needed --noconfirm zsh || error_exit "Failed to install zsh"
fi

# Set zsh as default shell if it isn't already
if [ "$SHELL" != "/bin/zsh" ]; then
    warning_msg "Setting zsh as default shell..."
    chsh -s /bin/zsh $(whoami) || error_exit "Failed to set zsh as default shell"
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    warning_msg "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || error_exit "Failed to install oh-my-zsh"
fi

success_msg "Installation and setup complete!"
echo -e "${GREEN}You can now start X server with 'startx'${NC}"
echo -e "${YELLOW}Note: A backup of your previous configuration has been saved to $BACKUP_DIR${NC}"

