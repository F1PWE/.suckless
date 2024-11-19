# Add common local directories to PATH
if [ -d "$HOME/.local/bin" ] ; then
	PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/.local/share/bin" ] ; then
	PATH="$HOME/.local/share/bin:$PATH"
fi

# Set default programs
export EDITOR="vim"
export TERMINAL="st"
export BROWSER="firefox"

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# For better font rendering
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
