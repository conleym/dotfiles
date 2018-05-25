# Some python crap that needs to be done for all shells.


python_version() {
    # Note that the python code here *must* work in both python 2 and 3.
    python -c 'import sys; print(".".join(str(x) for x in sys.version_info[:2]))'
}


python_user_dir() {
    local USERDIR
    USERDIR=$(python -m site --user-base)
    echo "${USERDIR}"
}


# Set up virtualenvwrapper.
venvwrapper_setup() {
    # Assumes virtualenvwrapper was installed for this python version with
    # 'pip install --user virtualenvwrapper'
    local PYDIR
    PYDIR=$(python_user_dir)
    . "${PYDIR}/bin/virtualenvwrapper.sh"
}
