
# XDG locations. Preserve existing non-empty values.
: "${XDG_CONFIG_HOME:=$HOME/.config}"
: "${XDG_DATA_HOME:=$HOME/.local/share}"
: "${XDG_CACHE_HOME:=$HOME/.cache}"
export XDG_CONFIG_HOME XDG_DATA_HOME XDG_CACHE_HOME

# User executable directories. Avoid duplicate PATH entries.
for _cyrmax_dir in "$HOME/.bin" "$HOME/bin" "$HOME/.local/bin"; do
    case ":$PATH:" in
        *":$_cyrmax_dir:"*) ;;
        *) PATH="$_cyrmax_dir:$PATH" ;;
    esac
done
unset _cyrmax_dir
export PATH

# Default tools, without overriding existing preferences.
: "${EDITOR:=nvim}"
: "${VISUAL:=$EDITOR}"
: "${PAGER:=less}"
export EDITOR VISUAL PAGER

# Use custom Readline settings only when present.
if [[ -r "$HOME/.inputrc" ]]; then
    : "${INPUTRC:=$HOME/.inputrc}"
    export INPUTRC
fi
