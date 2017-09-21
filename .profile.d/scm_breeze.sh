# Load SCM Breeze
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"

# TODO grab scm_breeze's ll alias and give it a new name.

# Aliases are checked before functions, and I've defined a function with this name, so this has to go.
unalias ll
