alias l="ls -1"
alias ll="ls -lh"
alias la="ls -lah"
alias n="nvim"
f() {
    fff "$@"
    local d=$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")
    [ -d "$d" ] && [ "$d" != "$PWD" ] && cd "$d"
}

check_tool xclip
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

