function javaselect() {
    local version="${1}"
    export JAVA_HOME=$(/usr/libexec/java_home -v "${version}")
    launchctl setenv JAVA_HOME "${JAVA_HOME}"

    # TODO restart finder/dock (???) so the launchctl setting can take effect?
    #    osascript -e 'tell app "Dock" to quit'
}
