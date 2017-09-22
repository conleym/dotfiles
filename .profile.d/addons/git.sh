ghclone() {
    for repo in "$@"; do
        git clone git@github.com:"${repo}".git
    done
}

gitppr() {
  git co master && git pull && gitclean
}
