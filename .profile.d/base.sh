# Only functions that are required by multiple shells during setup should be placed here.
#
# Everything in this file should be parseable by any Bourne shell.
#
#
# Some notes:
#
# The 'function' keyword is actually an extension supported by most shells. It is not
# supported by, e.g., (d)ash, so we won't use it here.
#
#


is_bash() {
    [ -n "$BASH_VERSION" ]
}


is_zsh() {
    [ -n "$ZSH_VERSION" ]
}


sourceall() {
    for file in "$@"; do
        [ -f "$file" ] && . "$file"
    done
}

is_regular_and_readable() {
    [ -f "${1}" ] && [ -r "${1}" ]
}

# Shortcut for assigning a heredoc to a variable.
# http://stackoverflow.com/a/8088167
define() {
    # read will have exit status 1 whenever it assigns to a variable or it gets to EOF.
    read -r -d '' "${1}" || true
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

# Load all addons.
load_all_addons() {
    globall "sourceall ~/.profile.d/addons/*.sh"
}


app_path() {
    local APP="${1}.app"
    local APPDIR="${2}"
    if [ -z "${APPDIR}" ]; then
        APPDIR="/Applications"
    fi
    APP="${APPDIR}/${APP}/Contents"
    echo "${APP}"
}


awk_default_awkpath() {
    # Subshell to safely unset $AWKPATH, which gets gawk to
    # shove the default value into ENVIRON.
    ( unset AWKPATH;
        echo '' | gawk '{ print ENVIRON["AWKPATH"] }'
    )
}


enable_proxy() {
    local address="${1:-localhost:3128}"
    local protocol=${2:-"http"}
    local proxy="${protocol}://${address}"

    export HTTP_PROXY="${proxy}"
    export http_proxy="${proxy}"

    export HTTPS_PROXY="${proxy}"
    export https_proxy="${proxy}"

    export FTP_PROXY="${proxy}"
    export ftp_proxy="${proxy}"

    # rsync does its own thing...of course.
    export RSYNC_PROXY="${address}"
}


disable_proxy() {
    unset HTTP_PROXY http_proxy HTTPS_PROXY https_proxy FTP_PROXY ftp_proxy RSYNC_PROXY
}


strjoin() {
    local IFS="${1}"
    shift
    echo "$*"
}


warn() {
    echo "$@" 1>&2
}
