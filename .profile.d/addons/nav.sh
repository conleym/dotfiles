alias lh='ls -Alh'
alias lrot='ls -Alhrot'


# Enable dirstack
cd() {
    local dir=${1:-~}
    # suppress dirstack output
    pushd "${dir}" > /dev/null
}

# common typos
alias cd..='cd ..'
alias cd-='cd -'

# up N
# Go up N directories.  Default value for N is 1.
#
up() {
    local num=${1:-1};
    if [ "${num}" -le 0 ]; then
        return 2;
    fi

    local str="";
    while [ $(( ${num} )) -gt 0 ]; do
        num=$(( ${num} - 1 ));
        str="${str}../";
    done
    cd "${str}"
}


which() {
    (alias; declare -f) | gwhich --tty-only --read-alias --read-functions --show-tilde --show-dot "$@"
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
