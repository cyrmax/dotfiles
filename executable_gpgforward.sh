#!/bin/bash
export GPG_TTY=$(tty)
socat - UNIX-CONNECT:"$HOME/.gnupg/S.gpg-agent.ssh" &

