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


python_scripts_dir() {
    # Note that the python code here *must* work in both python 2 and 3.
    python -c "import sysconfig; print(sysconfig.get_paths()['scripts'])"
}


# Set up virtualenvwrapper.
venvwrapper_setup() {
    local SCRIPT_FILE
    local SCRIPT

    SCRIPT_FILE="virtualenvwrapper.sh"

    # First try user dir.
    SCRIPT="$(python_user_dir)/bin/${SCRIPT_FILE}"
    if is_regular_and_readable "${SCRIPT}"; then
        . "${SCRIPT}"
    else
        # Try system dir.
        SCRIPT="$(python_scripts_dir)/${SCRIPT_FILE}"
        if is_regular_and_readable "${SCRIPT}"; then
            . "${SCRIPT}"
        fi
    fi
}
