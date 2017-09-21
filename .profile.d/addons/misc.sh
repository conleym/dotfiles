cls() {
    clear "$@"
}


rgrep() {
    /usr/bin/grep -rnE "$@"
}


findgrep() {
    local START="${1}"
    local GLOB="${2}"
    local REGEX="${3}"

    qfind "${START}" -name "${GLOB}" -exec grep -Hn "${REGEX}" {} \;
}


qfind() {
    find "$@" 2>/dev/null
}


rcp() {
    /bin/cp -R "$@"
}


pgsql() {
    psql "$@"
}


tidyxml() {
    local tmp
    tmp=$(mktemp "tidy")
    tidy -xml -indent "${1}" > "${tmp}"
    mv "${tmp}" "${1}"
}


isodate() {
    date -ju "$@" "+%Y-%m-%dT%H:%M:%SZ"
}


pubip() {
    curl ipecho.net/plain; echo
}


# Colorized manpages
man() {
    env \
        LESS_TERMCAP_mb=$'\e[1;31m' \
        LESS_TERMCAP_md=$'\e[1;31m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[1;44;33m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[1;32m' \
            man "$@"
}


apb() {
  ansible-playbook "$@"
}
