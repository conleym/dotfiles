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
plugins=(ant aws cabal catimg celery colored-man-pages cpanm
         docker encode64 extract fabric gem git
         jsontools lein macports mvn node npm osx
         pep8 perl pip pyenv pylint python
         screen shell-aws-autoprofile svn themes tmux urltools
         vagrant virtualenv virtualenvwrapper vscode web-search xcode yarn)

source $ZSH/oh-my-zsh.sh
# end of oh-my-zsh config

# Load all shell addons
load_all_addons

# iTerm2 shell integration
maybe_source  ~/.zsh/.iterm2_shell_integration.zsh

maybe_source /opt/local/etc/profile.d/bash_completion.sh

# Named bash_completion, but also works with zsh and bashcompinit.
maybe_source ~/.nvm/bash_completion

if command -v grunt 2>&1 >/dev/null; then
    eval "$(grunt --completion=zsh)"
fi
