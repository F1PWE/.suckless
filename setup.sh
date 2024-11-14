#!/bin/bash

# Check if git is installed, if not, install it
if ! command -v git &> /dev/null; then
    echo "Git not found. Installing Git..."
    sudo pacman -S --needed --noconfirm git
else
    echo "Git is already installed."
fi

# Clone the repository
echo "Cloning Git repo..."
git clone https://github.com/F1PWE/.suckless.git $HOME/.my_dwm
sleep 0.5

# Check if dotfiles directory exists in the repo after cloning
if [ ! -d "$HOME/.my_dwm/dotfiles" ]; then
    echo "Dotfiles directory not found in the repository. Please check the repo structure."
    exit 1
else
    echo "Dotfiles directory found. Proceeding with copying dotfiles."
fi

# Install required packages from requirements.txt
echo "Installing required packages..."
if [ -f $HOME/.my_dwm/requirements.txt ]; then
    echo "Installing required packages from requirements.txt..."
    sudo pacman -S --needed --noconfirm $(cat $HOME/.my_dwm/requirements.txt | xargs)
else
    echo "requirements.txt not found. Skipping package installation."
fi

# Extract dotfiles to home (including hidden files)
echo "Extracting dotfiles to home..."
shopt -s dotglob  # Enable dotglob to include hidden files
cp -r $HOME/.my_dwm/dotfiles/* $HOME/
shopt -u dotglob  # Disable dotglob

# Extract scripts to home
echo "Extracting scripts to home..."
cp -r $HOME/.my_dwm/scripts/* $HOME/

# Move backgrounds folder from repo to home
echo "Moving backgrounds folder to home..."
cp -r $HOME/.my_dwm/backgrounds $HOME/

sleep 0.5

# Source .profile to apply changes immediately
echo "Sourcing .profile to apply environment changes..."
source $HOME/.profile
sleep 0.5

# Extract dwm and related programs to home
echo "Extracting dwm and related programs..."
cp -r $HOME/.my_dwm/.suckless $HOME/
sleep 0.5

# Compile dwm and related programs
echo "Compiling dwm and related programs..."
for program in dwm st slstatus dmenu; do
    cd $HOME/.my_dwm/.suckless/$program  # Corrected path to .suckless folder
    make PREFIX=$HOME/.local/ install
done

echo "Installation and setup complete!"

