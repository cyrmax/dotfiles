# WSL-specific interactive utilities.
if [[ -n "${WSL_DISTRO_NAME:-}" ]]; then
    open() {
        local win_path
        win_path="$(wslpath -w "$1")" || return 1
        cmd.exe /C start "" "$win_path"
    }
fi
