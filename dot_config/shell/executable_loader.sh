# Main loader for Bash and Zsh
check_tool() {
    local tool=$1
    local ignore_file="$HOME/.config/shell/toolignore"
    if [[ -f "$ignore_file" ]] && grep -qx "$tool" "$ignore_file"; then
        return 0
    fi
    if ! command -v "$tool" >/dev/null 2>&1; then
        echo "$tool not found. Install it or add to $ignore_file"
    fi
}

for module in "$HOME/.config/shell/env.d"/*.sh; do
    [ -r "$module" ] && . "$module"
done
