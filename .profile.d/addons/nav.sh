# -*- mode: shell-script; -*-

# Enable dirstack
cd() {
    local dir=${1:-~}
    # suppress dirstack output
    pushd "${dir}" > /dev/null
}


cd..() {
    cd ..
}


cd-() {
    cd -
}


lh() {
    ls -Alh "$@"
}


lrot() {
    ls -Alhrot "$@"
}


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
