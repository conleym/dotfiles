test -r "${HOME}/.profile.d/base.sh" && source "${HOME}/.profile.d/base.sh"

maybe_source "${HOME}/.iterm2_shell_integration.zsh"


export HISTIGNORE=""
export HISTFILESIZE=100000
export HISTSIZE=${HISTFILESIZE}
export SAVEHIST=${HISTSIZE}

setopt append_history hist_verify hist_ignore_all_dups hist_reduce_blanks


# cd_silent requires 5.8+
# TODO note that this check only works up til 5.10 comes out, at which point it will
# need adjustment.
if [[ "${ZSH_VERSION}" > '5.8' || "${ZSH_VERSION}" == '5.8' ]]; then
    setopt cd_silent
fi
setopt pushd_silent pushd_to_home

setopt extended_glob glob_star_short glob_dots

export JAVA_HOME=$(/usr/libexec/java_home)

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

export THEFUCK_REQUIRE_CONFIRMATION='true'
eval $(thefuck --alias)

alias config='git --git-dir=$HOME/.cfg --work-tree=$HOME'

zstyle ':compinstall' filename "${HOME}/.zsh/.zshrc"

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
plugins=(ansible aws colored-man-pages docker git macports npm osx pip virtualenv virtualenvwrapper yarn)
. $ZSH/oh-my-zsh.sh

globall "sourceall ~/.profile.d/addons/*.sh"
