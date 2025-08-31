# Sourced for all interactive shells. This is the place for aliases and such.

test -r "${HOME}/.profile.d/base.sh" && source "${HOME}/.profile.d/base.sh"

# Node version manager.
maybe_source "${HOME}/.nvm/nvm.sh"
# Rust.
maybe_source "${HOME}/.cargo/env"

# There's no python3.7 executable installed with the XCode command line tools. Use 3 instead.
export PATH="${HOME}/bin:$(app_bindir Emacs):$(app_bindir Emacs)/bin:$(app_bindir VLC):$(python_user_dir 3)/bin:${PATH}"

# Default is waaay too long.
export PGCONNECT_TIMEOUT=10

export LANG=en_US.UTF-8

# Enable ls -G.
export CLICOLOR=""
export LSCOLORS="Gxfxcxdxbxegedabagacad"

export HISTIGNORE=""
export HISTFILESIZE=100000
export HISTSIZE=${HISTFILESIZE}
export SAVEHIST=${HISTSIZE}

setopt append_history hist_verify hist_ignore_all_dups hist_reduce_blanks


# cd_silent requires 5.8+
setopt cd_silent
setopt pushd_silent pushd_to_home

setopt extended_glob glob_star_short glob_dots

#export JAVA_HOME=$(/usr/libexec/java_home)

# Make emacs my editor for all the things.
export EDITOR=emacsclient               # lots of things
export FCEDIT="${EDITOR}"               # for fc -e (shell builtin)
export MP_EDITOR="${EDITOR}"            # macports
export VISUAL="${EDITOR}"               # lots of things

# Start emacs server automatically as needed when emacsclient runs.
export ALTERNATE_EDITOR=''


# Virtualenvwrapper needs to use python3, because that's where it's installed.
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3


# Configure lesspipe. Note that less is already the default pager on macOS.
export LESSOPEN='| /opt/local/bin/lesspipe.sh %s'

alias config='git --git-dir=$HOME/.cfg --work-tree=$HOME'

#zstyle ':compinstall' filename "${HOME}/.zsh/.zshrc"

# Enable tab completion
autoload -Uz +X compinit && compinit
# Add zsh-completions to function path.
fpath=(/opt/local/share/zsh/site-functions $fpath)

# Makes bash completion work, too.
autoload -Uz +X bashcompinit && bashcompinit
# Load bash completion scripts.
maybe_source /opt/local/etc/profile.d/bash_completion.sh
maybe_source ~/.nvm/bash_completion

# oh-my-zsh
DISABLE_UPDATE_PROMPT=true
ZSH=~/.zsh/ohmyzsh
plugins=(alias-finder ansible aws catimg colored-man-pages docker git macos macports npm pip virtualenv virtualenvwrapper)
. $ZSH/oh-my-zsh.sh

# aliased to 'ls -G' by oh-my-zsh, but handled by CLICOLOR env var.
# This alias messes with eshell, mainly because gnu ls and bsd ls disagree on the meaning of -G.
alias ls='ls -F'

globall "sourceall ~/.profile.d/addons/*.sh"

# pnpm
export PNPM_HOME="/Users/mike/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/mike/.docker/completions $fpath)
# End of Docker CLI completions


# 1pw cli plugins
maybe_source ~/.config/op/plugins.sh
