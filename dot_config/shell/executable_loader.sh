# Common interactive environment for Bash and Zsh.
case "$-" in
    *i*) ;;
    *) return 0 ;;
esac

check_tool() {
    local tool="$1"
    local ignore_file="${XDG_CONFIG_HOME:-$HOME/.config}/shell/toolignore"

    if [[ -r "$ignore_file" ]] &&
       grep -Fxq -- "$tool" "$ignore_file"; then
        return 0
    fi

    if ! command -v "$tool" >/dev/null 2>&1; then
        printf '%s not found. Install it or add to %s\n' \
            "$tool" "$ignore_file" >&2
    fi
}

_cyrmax_load_shell_modules() {
    local module

    # Avoid NOMATCH errors in Zsh on empty module directories.
    if [[ -n "${ZSH_VERSION:-}" ]]; then
        setopt local_options null_glob
    fi

    for module in "${XDG_CONFIG_HOME:-$HOME/.config}"/shell/env.d/*.sh; do
        [[ -f "$module" && -r "$module" ]] && . "$module"
    done
}

_cyrmax_load_shell_modules
unset -f _cyrmax_load_shell_modules

_cyrmax_shell_dir="${XDG_CONFIG_HOME:-$HOME/.config}/shell"

if [[ -n "${ZSH_VERSION:-}" ]]; then
    [[ -r "$_cyrmax_shell_dir/zsh.sh" ]] && . "$_cyrmax_shell_dir/zsh.sh"
elif [[ -n "${BASH_VERSION:-}" ]]; then
    [[ -r "$_cyrmax_shell_dir/bash.sh" ]] && . "$_cyrmax_shell_dir/bash.sh"
fi

unset _cyrmax_shell_dir
