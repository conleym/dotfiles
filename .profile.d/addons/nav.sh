# -*- mode: shell-script; -*-

# Enable dirstack
function cd() {
    local dir=${1:-~}
    # suppress dirstack output
    pushd "${dir}" > /dev/null
}


function cd..() {
    cd ..
}


function cd-() {
    cd -
}


function lh() {
    ls -Alh "$@"
}


function lrot() {
    ls -Alhrot "$@"
}


# up N
# Go up N directories.  Default value for N is 1.
#
function up() {
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


function which() {
    (alias; declare -f) | gwhich --tty-only --read-alias --read-functions --show-tilde --show-dot "$@"
}
