# Disable Apple's session management. zsh already has session management.
# See https://apple.stackexchange.com/questions/427561/macos-zsh-sessions-zsh-history-and-setopt-append-history
# and /etc/zshrc_Apple_Terminal
#
# Although it is claimed that this can be set in .zshrc, that seems not to be the case,
# as ~/.zsh/.zsh_sessions will still appear with that setting in place when closing the terminal.
export SHELL_SESSIONS_DISABLE=1

export ZDOTDIR=~/.zsh
