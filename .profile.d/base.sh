# Some shell programming utilities.

is_bash() {
    [ -n "$BASH_VERSION" ]
}


is_zsh() {
    [ -n "$ZSH_VERSION" ]
}


# Shortcut for assigning a heredoc to a variable.
# http://stackoverflow.com/a/8088167
define() {
    # read will have exit status 1 whenever it assigns to a variable or it gets to EOF.
    read -r -d '' "${1}" || true
}


is_regular_and_readable() {
    [ -f "${1}" ] && [ -r "${1}" ]
}


# Join args beyond the first, inserting a single character between them.
strjoin() {
    local IFS
    IFS="${1}"
    shift
    echo "$*"
}


warn() {
    echo "$@" 1>&2
}


maybe_source() {
    if is_regular_and_readable "${1}"; then
        . "${1}"
    fi
}


# Glob without warnings or errors if no files match
globall() {
    if is_bash; then
        shopt -s nullglob
        eval "$@"
        shopt -u nullglob
    elif is_zsh; then
        setopt null_glob
        eval "$@"
        unsetopt null_glob
        # TODO what to do about other shells?
    fi
}


sourceall() {
    for file in "$@"; do
        maybe_source "${file}"
    done
}


python_user_dir() {
    local VERSION
    local USERDIR
    VERSION="${1:-}"
    USERDIR=$("python${VERSION}" -m site --user-base)
    echo "${USERDIR}"
}


# Local Variables:
# mode: sh
# sh-shell: zsh
# End:
