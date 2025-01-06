source ~/alloyhome/alloy/shell/postgres.sh

if [ -x ~/bin/doppler]; then
    source <(doppler completion 2> /dev/null)
fi
