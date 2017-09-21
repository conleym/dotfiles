# Start with common profile.
. ~/.profile


HISTFILE=~/.zsh/.histfile
SAVEHIST=${HISTSIZE}

setopt append_history autocd autopushd extended_glob glob_dots hist_verify \
       hist_ignore_all_dups pushd_ignore_dups pushd_silent pushd_to_home
# beeping is dumb
unsetopt beep
# emacs mode
bindkey -e
zstyle :compinstall filename '/Users/mike/.zsh/.zshrc'

autoload -Uz compinit && compinit
# Makes bash completion work, too.
autoload -U +X bashcompinit && bashcompinit


# oh-my-zsh config
DISABLE_UPDATE_PROMPT=true
ZSH=~/.zsh/oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(ant aws brew cabal catimg celery colored-man cpanm
         docker encode64 gem git
         jsontools lein macports mvn npm nyan osx pep8 perl pip pylint python
         redis-cli screen supervisor svn terminalapp themes tmux urltools
         vagrant virtualenv virtualenvwrapper web-search xcode)

source $ZSH/oh-my-zsh.sh
# end of oh-my-zsh config


# Load SCM Breeze
#. ~/.profile.d/scm_breeze.sh

# Load all shell addons
load_all_addons

# Named bash_completion, but also works with zsh and bashcompinit.
[[ -r ~/.nvm/bash_completion ]] && . ~/.nvm/bash_completion

if command -v grunt 2>&1 >/dev/null; then
    # Requires bashcompinit.
    eval "$(grunt --completion=bash)"
fi
