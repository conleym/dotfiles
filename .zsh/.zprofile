test -r "${HOME}/.profile.d/base.sh" && source "${HOME}/.profile.d/base.sh"

maybe_source "${HOME}/.nvm/nvm.sh"

# There's no python3.7 executable installed with the XCode command line tools. Use 3 instead.
export PATH="${HOME}/bin:$(app_bindir Emacs):$(app_bindir Emacs)/bin:$(app_bindir VLC):$(python_user_dir 3)/bin:${PATH}"

# Default is waaay too long.
export PGCONNECT_TIMEOUT=10

export LANG=en_US.UTF-8
