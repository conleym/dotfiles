test -r "${HOME}/.profile.d/base.sh" && source "${HOME}/.profile.d/base.sh"

maybe_source "${HOME}/.nvm/nvm.sh"

# There's no python3.7 executable installed with the XCode command line tools...
PYTHON3_USER_DIR=$(python_user_dir 3)
PYTHON27_USER_DIR=$(python_user_dir 2.7)

export PATH="${HOME}/bin:/Applications/Emacs.app/Contents/MacOS:/Applications/Emacs.app/Contents/MacOS/bin:${PYTHON3_USER_DIR}/bin:${PYTHON27_USER_DIR}/bin:${PATH}"

unset PYTHON3_USER_DIR
unset PYTHON27_USER_DIR

# Default is waaay too long.
export PGCONNECT_TIMEOUT=10

export LANG=en_US.UTF-8
