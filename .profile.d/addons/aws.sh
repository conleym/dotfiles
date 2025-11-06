_other_aws_common_stuff() {
    export AWS_DEFAULT_PROFILE="${AWS_PROFILE}"
    local SCRIPT
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
    define SCRIPT <<EOF
  from botocore.session import Session
  s = Session()
  c = s.get_credentials()
  if c:
     print('export AWS_ACCESS_KEY_ID=' + c.access_key)
     print('export AWS_SECRET_ACCESS_KEY=' + c.secret_key)
EOF
    local RESULT
    RESULT=$(echo "${SCRIPT}" | /usr/bin/python3)
    eval "${RESULT}"
}


# Export AWS variables associated with a given profile.
# This can be useful for switching among multiple profiles, and also for
# software that needs the various environment variables to be explicitly present
# (e.g., if you need to get them substituted into a java properties file using a
# framework that supports such things).
use_aws() {
    export AWS_PROFILE="${1}"
    _other_aws_common_stuff
}


# http://stackoverflow.com/questions/33791069/quick-way-to-get-aws-account-number-from-the-cli-tools
aws_account_id() {
    aws ec2 describe-security-groups \
        --group-names 'Default' \
        --query 'SecurityGroups[0].OwnerId' \
        --output text
}


# Local Variables:
# mode: sh
# sh-shell: zsh
# End:

