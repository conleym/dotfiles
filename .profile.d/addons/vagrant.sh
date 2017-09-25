function vagrant() {
  local EXE
  EXE="/usr/local/bin/vagrant"
  if [[ "${1}" == "reup" ]]; then
    "${EXE}" destroy -f; "${EXE}" up
  elif [[ "${1}" == "st" ]]; then
    "${EXE}" status
  else
    "${EXE}" "$@"
  fi
}
