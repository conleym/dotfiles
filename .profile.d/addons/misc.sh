alias apb='ansible-playbook'
alias cls='clear'
alias rgrep='grep -rnE'


tidyxml() {
    local tmp
    tmp=$(mktemp "tidy")
    tidy -xml -indent "${1}" > "${tmp}"
    mv "${tmp}" "${1}"
}


isodate() {
    date -ju "$@" "+%Y-%m-%dT%H:%M:%SZ"
}


epochdate() {
    date -j -f "%a %b %d %T %Z %Y" "$(date)" "+%s"
}


pubip() {
    curl ipecho.net/plain; echo
}


# Read a file into the clipboard
pbcat() {
    pbcopy  < "${1}"
}


# Local Variables:
# mode: sh
# sh-shell: zsh
# End:
