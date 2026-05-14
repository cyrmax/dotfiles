if [ -n "$ZSH_VERSION" ]; then
[ -f "/usr/share/doc/pkgfile/command-not-found.zsh" ] && source "/usr/share/doc/pkgfile/command-not-found.zsh"
elif [ -n "$BASH_VERSION" ]; then
[ -f "/usr/share/doc/pkgfile/command-not-found.bash" ] && source "/usr/share/doc/pkgfile/command-not-found.bash"
fi

