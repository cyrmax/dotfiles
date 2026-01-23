if [[ -v WSL_DISTRO_NAME ]]; then
    [ -x /usr/sbin/wsl2-ssh-agent ] && eval "$(/usr/sbin/wsl2-ssh-agent)" || check_tool "wsl2-ssh-agent"
    alias pbcopy="win32yank.exe -i"
    alias pbpaste="win32yank.exe -o"
    open() {
        local win_path=$(wslpath -w "$1")
        cmd.exe /C start "" "$win_path"
    }
fi
