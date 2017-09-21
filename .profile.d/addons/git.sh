function ghclone() {
    for repo in "$@"; do
        git clone git@github.com:"${repo}".git
    done
}

function gitppr() {
  git co master && git pull && gitclean
}
