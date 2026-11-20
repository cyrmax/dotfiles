# GnuPG and SSH environment for interactive Bash and Zsh.

# Tell GnuPG which terminal belongs to this shell.
if [[ -t 0 ]] && command -v tty >/dev/null 2>&1; then
    _cyrmax_tty="$(tty 2>/dev/null)"
    if [[ "$_cyrmax_tty" == /dev/* ]]; then
        export GPG_TTY="$_cyrmax_tty"
    fi
    unset _cyrmax_tty
fi

_cyrmax_configure_ssh_agent() {
    command -v gpgconf >/dev/null 2>&1 || return 0

    local agent_socket
    agent_socket="$(gpgconf --list-dirs agent-ssh-socket 2>/dev/null)"

    [[ -n "$agent_socket" && -S "$agent_socket" ]] || return 0

    # Preserve working SSH forwarding on remote connections.
    if [[ -n "${SSH_CONNECTION:-}" &&
          -n "${SSH_AUTH_SOCK:-}" &&
          -S "$SSH_AUTH_SOCK" ]]; then
        return 0
    fi

    # WSL always prefers the configured Windows GPG-agent bridge
    # for local sessions.
    if [[ -n "${WSL_DISTRO_NAME:-}" ]]; then
        export SSH_AUTH_SOCK="$agent_socket"
        unset SSH_AGENT_PID
        return 0
    fi

    # Preserve an existing working local agent.
    if [[ -n "${SSH_AUTH_SOCK:-}" && -S "$SSH_AUTH_SOCK" ]]; then
        return 0
    fi

    # Otherwise use the local GnuPG SSH agent.
    export SSH_AUTH_SOCK="$agent_socket"
    unset SSH_AGENT_PID
}

_cyrmax_configure_ssh_agent
unset -f _cyrmax_configure_ssh_agent

# Direct GPG-agent prompts to the current SSH terminal.
# Do not touch a forwarded SSH agent.
if [[ -n "${SSH_CONNECTION:-}" && -n "${GPG_TTY:-}" ]] &&
   command -v gpg-connect-agent >/dev/null 2>&1 &&
   [[ "${SSH_AUTH_SOCK:-}" == "$(gpgconf --list-dirs agent-ssh-socket 2>/dev/null)" ]]; then
    gpg-connect-agent UPDATESTARTUPTTY /bye >/dev/null 2>&1 || true
fi
