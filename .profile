# Common profile for bash and zsh.


#export DEFAULT_GATEWAY=`netstat -nr | sed -n '/^default/s/\s\s*/ /gp' | cut -d' ' -f2`


# Load my base functions. These are used in other profile functions
# defined later in shell-specific init files, and also here, e.g., to build
# PATH.
. ~/.profile.d/base.sh


# Set some dev tool paths.
export WORKON_HOME=~/venvs
JAVA_HOME=$(/usr/libexec/java_home)
export JAVA_HOME
export M2_HOME=~/software/apache-maven
export ANT_HOME=~/software/apache-ant
export ANSIBLE_RETRY_FILES_ENABLED=0
export ANSIBLE_NOCOWS=1
export CVSROOT=~/repositories/cvs

# Move the babel cache
export BABEL_CACHE_PATH=~/.cache/babel-cache.json

# Default is waaay too long.
export PGCONNECT_TIMEOUT=2

# Somehow the parallels provider makes itself the default. Annoying.
export VAGRANT_DEFAULT_PROVIDER=virtualbox

# For some reason XTerm has TERM=xterm, not xterm-256color
if [ -n "${XTERM_VERSION}" ]; then
  export TERM=xterm-256color
fi

#
# Build $PATH
#
EMACS=$(app_path Emacs)
EMACS_BIN="${EMACS}/MacOS:${EMACS}/MacOS/bin"
EMACS_MAN="${EMACS}/Resources/man"
alias emacs="${EMACS}/MacOS/Emacs"
unset EMACS
OO="$(app_path LibreOffice)/MacOS"

export PATH=~/Library/Haskell/bin:~/.cask/bin:~/bin/pylinks:~/bin:${EMACS_BIN}:${ANT_HOME}/bin:${M2_HOME}/bin:${PATH}:${OO}

unset EMACS_BIN OO
#
# $PATH is now built (mostly -- some executables will modify it further later on).

export MANPATH="${EMACS_MAN}:${MANPATH}"
unset EMACS_MAN

# History control variables shared by bash and zsh.
export HISTCONTROL="erasedups"
export HISTIGNORE=""
export HISTFILESIZE=100000
export HISTSIZE=${HISTFILESIZE}

# Make emacs my editor for all the things.
export EDITOR=emacsclient               # lots of things
export FCEDIT="${EDITOR}"               # for fc -e (bash builtin)
export MP_EDITOR="${EDITOR}"            # macports
export VISUAL="${EDITOR}"               # lots of things

# emacsclient should start the server if one isn't already running.
export ALTERNATE_EDITOR="emacs"

# And less my pager for all the things.
export PAGER="less"
export LESSOPEN='| /opt/local/bin/lesspipe.sh %s'

# Don't try to use uninstalled packages.
export PKG_CONFIG_DISABLE_UNINSTALLED=""
# Default directories are always searched, but by default path entries come first.
# So we put the default first *in the path*.
PKG_CONFIG_PATH=$(pkg-config --variable pc_path pkg-config)
PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/opt/X11/lib/pkgconfig:/opt/X11/share/pkgconfig:/usr/lib/pkgconfig:/usr/local/lib/pkgconfig"
export PKG_CONFIG_PATH

AWKPATH=$(awk_default_awkpath)
export AWKPATH

alias config='git --git-dir=$HOME/.cfg --work-tree=$HOME'

# Set up virtualenvwrapper.
. ~/.profile.d/python.sh
venvwrapper_setup

# Set up nvm
. ~/.nvm/nvm.sh

# Set up AWS variable(s).
. ~/.profile.d/aws.sh
aws_mine

# Set up thefuck
. ~/.profile.d/thefuck.sh


# Tell perl to use ~/perl5 for libraries.
[ $SHLVL -eq 1 ] && eval "$(perl -I"${HOME}"/perl5/lib/perl5 -Mlocal::lib)"


# rbenv setup
if [[ -d ~/.rbenv ]]; then
  PATH="${PATH}:"~"/.rbenv/bin"
  eval "$(rbenv init -)"
fi
# Add binaries from local rubygems install to path. Needed for puppet-lint.
if which ruby >/dev/null && which gem >/dev/null; then
  PATH="${PATH}:$(ruby -rubygems -e 'puts Gem.user_dir')/bin"
fi

# pyenv setup
#if [[ -d ~/.pyenv ]]; then
#  export PYENV_ROOT=~"/.pyenv"
#  export PATH="${PATH}:${PYENV_ROOT}/bin"
#  eval "$(pyenv init -)"
#  if [[ -d ~/.pyenv/plugins/pyenv-virtualenv ]]; then
#    eval "$(pyenv virtualenv-init -)"
#  fi
#fi

# Use `hub` in place of `git`
#eval "$(hub alias -s)"

CC=$(xcrun --find clang)
export CC

# Add macports and X11 dirs to lib/include paths for command line builds.
export LDFLAGS="${LDFLAGS} -L/opt/X11/lib -L/opt/local/lib"
export CPPFLAGS="${CPPFLAGS} -I/opt/X11/include -I/opt/local/include"


ssh-add -K ~/.ssh/*.pem > /dev/null 2>&1
