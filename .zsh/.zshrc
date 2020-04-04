test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export EDITOR=
export JAVA_HOME=$(/usr/libexec/java_home)

# Make emacs my editor for all the things.
export EDITOR=emacsclient               # lots of things
export FCEDIT="${EDITOR}"               # for fc -e (shell builtin)
export MP_EDITOR="${EDITOR}"            # macports
export VISUAL="${EDITOR}"               # lots of things

# Start emacs daemon automatically
export ALTERNATE_EDITOR=''


# Virtualenvwrapper needs to use python3, because that's where it's installed.
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3


# Configure lesspipe. Note that less is already the default pager on macOS.
export LESSOPEN='| /opt/local/bin/lesspipe.sh %s'

export THEFUCK_REQUIRE_CONFIRMATION='true'
eval $(thefuck --alias)

alias config='git --git-dir=$HOME/.cfg --work-tree=$HOME'


# oh-my-zsh
DISABLE_UPDATE_PROMPT=true
ZSH=~/.zsh/ohmyzsh
plugins=(ansible aws colored-man-pages docker git macports npm nvm osx pip virtualenv virtualenvwrapper yarn)
. $ZSH/oh-my-zsh.sh
