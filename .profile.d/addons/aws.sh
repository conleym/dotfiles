_other_aws_common_stuff() {
  export AWS_DEFAULT_PROFILE="${AWS_PROFILE}"
  local SCRIPT
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
  define SCRIPT <<EOF
try:
  # Prefer boto3
  from botocore.session import Session
  s = Session()
  c = s.get_credentials()
  if c:
     print('export AWS_ACCESS_KEY_ID=' + c.access_key)
     print('export AWS_SECRET_ACCESS_KEY=' + c.secret_key)
except ImportError as e:
  # Try boto if boto3 isn't available.
  from boto.provider import Provider
  p = Provider('aws')
  print('export AWS_ACCESS_KEY_ID=' + p.get_access_key())
  print('export AWS_SECRET_ACCESS_KEY=' + p.get_secret_key())
EOF
  local RESULT
  RESULT=$(echo "${SCRIPT}" | /usr/bin/python3)
  eval "${RESULT}"
}

aws_mine() {
  export AWS_PROFILE=personal
  _other_aws_common_stuff
}


# http://stackoverflow.com/questions/33791069/quick-way-to-get-aws-account-number-from-the-cli-tools
aws_account_id() {
 aws ec2 describe-security-groups \
    --group-names 'Default' \
    --query 'SecurityGroups[0].OwnerId' \
    --output text
}

