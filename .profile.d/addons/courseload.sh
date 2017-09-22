clclone() {
    for repo in "$@"; do
        git clone git@github.com:unizin/"${repo}".git
    done
}


pgdev() {
    local dbname="${1:-127.0.0.1}"
    (( $# > 0 )) && shift
    psql -h 10.100.100.5 -U postgres -p 6432 -d "${dbname}" "$@"
}


pgstaging () {
    local db=${1:-'staging.courseload.com'}
    (( $# > 0 )) && shift
    psql --host="localhost" --port="65500" --username="courseload" --dbname="${db}" "$@"
}


_pgprod() {
    local db="${1}"
    local username=${2:-'courseload'}
    (( $# > 1 )) && shift 2
    if [[ -z "${db}" || -z "${username}" ]]; then
        warn "usage: ${0} database_name username"
        return 1
    fi
    psql --host="localhost" --port="65520" --username="${username}" --dbname="${db}" "$@"
}


pgprod() {
    local db="${1}"
    (( $# > 0 )) && shift
    _pgprod "${db}" "courseload" "$@"
}


pgprodadmin() {
    local db="${1}"
    (( $# > 0 )) && shift
    _pgprod "${db}" "courseloadadmin" "$@"
}

pgops() {
  local db="${1:-postgres}"
  (( $# > 0 )) && shift
  psql --username=devops --port=5432 --host="devops-testing.cy45nlkcoymw.us-east-2.rds.amazonaws.com" "$@"
}


pgcadbprod() {
  local db=${1:-'cl_content_analysis_production'}
  local username=${2:-'analysis_prod'}
  psql --host="localhost" --port="65510" --username="${username}" --dbname="${db}" "$@"
}


# Update all the git things
clupdate() {
    find ~/courseload -maxdepth 1 -type d -not -name '.*' -not -name '*.bak' \
         -not -name 'courseload' -exec sh -c 'cd "$1" && echo "$1" && git pull \
         && gitclean' _ {} \;
}
