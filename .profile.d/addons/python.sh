pypath() {
  local PROGRAM
  define PROGRAM <<-'EOF'
import sys
for dir in sys.path[1:]:
        print(dir)
EOF
  python -c "${PROGRAM}"
}


# Requires a django install to work, obviously.
djangopath() {
  local PROGRAM
  define PROGRAM <<-EOF
import sys
sys.path = sys.path[1:]
import django
for dir in django.__path__:
    print(dir)
EOF
  python -c "${PROGRAM}"
}


_create_python_links() {
  local DESTDIR=~/bin/pylinks
  /bin/rm -f ${DESTDIR}/*
  for cmd in $(python_user_dir)/bin/*; do
    local source="${cmd}"
    local target
    target=${DESTDIR}/$(basename "${cmd}")
    if [ -x "${source}" ] && [ -f "${source}" ]; then
      if [ -h "${target}" ]; then
        ln -fs "${source}" "${target}"
      else
        ln -s "${source}" "${target}"
      fi
    fi
  done
  rehash
}


pyselect() {
  # Default version is 2.7.
  local VERSION="${1:-27}"

  sudo port select python "python${VERSION}" &&
    if [[ ! "${VERSION}" =~ ^.*-apple$ ]]; then
      sudo port select pip "pip${VERSION}" &&
        sudo port select virtualenv "virtualenv${VERSION}"
    fi
  # set virtualenvwrapper scripts up for this python. defined in base.sh
  venvwrapper_setup
  # make symlinks in ~/bin to executables installed in this python's user dir.
  _create_python_links
  rehash
}


update_user_pip_modules() {
  # Use full path to avoid accidentally trampling virtualenvs with pinned
  # packages and whatnot.
  local PIP
  local OUTDATED_PACKAGES
  PIP="/opt/local/bin/pip"
  OUTDATED_PACKAGES=$("${PIP}" list --user --outdated | cut -d " " -f 1)
  for OUTDATED_PACKAGE in ${OUTDATED_PACKAGES}; do
    "${PIP}" install --user -U "${OUTDATED_PACKAGE}"
  done
  _create_python_links
}
