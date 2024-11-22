# FIRCH

A minimal Arch Linux setup script following the [suckless philosophy](https://suckless.org/philosophy/).

## install

```bash
wget firchwm.xyz/setup.sh
chmod +x setup.sh
./setup.sh
```

## features

- DWM window manager
- ST terminal
- Clean dotfiles
- Automatic configuration
- Zero bloat

## core programs

- dwm - Dynamic window manager
- st - Simple terminal
- dmenu - Dynamic menu
- slstatus - Status monitor

## additional software

- System: xorg-server, picom, libx11, networkmanager
- Development: base-devel, github-cli, neovim
- Utilities: btop, neofetch, man-db
- Browser: firefox
- Audio: pulseaudio, pulsemixer, mpd, ncmpcpp
- Media: mpv (video), nsxiv (images), mupdf (pdf)
- Files: ranger (file manager), unzip, unrar, rsync
- Mail: neomutt

## requirements

- Fresh Arch-based Linux installation
- Working internet connection
- At least 2GB free disk space

## keybindings

### window manager (dwm)
```
[Win] + [Return]          Launch terminal
[Win] + [w]               Launch Firefox
[Win] + [p]               Open dmenu
[Win] + [b]               Toggle bar
[Win] + [j/k]             Focus next/previous window
[Win] + [h/l]             Decrease/increase master size
[Win] + [i/d]             Add/remove master windows
[Win] + [q]               Kill window
[Win] + [t]               Tiling mode
[Win] + [f]               Floating mode
[Win] + [m]               Monocle mode
[Win] + [space]           Toggle between layouts
[Win] + [shift] + [space] Toggle floating
[Win] + [-/=]             Decrease/increase gaps
[Win] + [shift] + [=]     Reset gaps
[Win] + [1-9]             Switch to workspace
[Win] + [shift] + [1-9]   Move window to workspace
[Win] + [shift] + [q]     Quit dwm
```

### terminal (st)
```
[Ctrl] + [Shift] + [c]  Copy
[Ctrl] + [Shift] + [v]  Paste
[Ctrl] + [Shift] + [y]  Copy selected text
[Ctrl] + [Shift] + [PageUp]    Zoom in
[Ctrl] + [Shift] + [PageDown]  Zoom out
[Ctrl] + [Shift] + [Home]      Reset zoom
```

### mouse controls
```
[Win] + [Left Click]    Move window
[Win] + [Right Click]   Resize window
[Win] + [Middle Click]  Toggle floating
```

## about

FIRCH is a minimal window manager configuration built on top of dwm, following the suckless philosophy of simplicity and efficiency. It aims to provide a clean, fast, and distraction-free computing environment.

The project started as a personal configuration to eliminate unnecessary bloat while maintaining full functionality. It uses only essential software and configurations, making it ideal for both new arch users wanting a minimal setup and experienced users seeking a clean slate.

The setup script is open source and can be reviewed before running. Users are encouraged to fork the repository and modify the configurations to match their preferences.

⚠️ Contributions and feedback are welcome!

## cleanup

To remove FIRCH from your system:

```bash
wget firchwm.xyz/cleanup.sh
chmod +x cleanup.sh
./cleanup.sh
```

## license

This project is licensed under the GPL 2.0 License. See [LICENSE](LICENSE) for more details.
