# Set default host for forgejo cli
[ ! -v "$(command -v fj)" ] && export FJ_FALLBACK_HOST="https://git.cyrmax.ru"

