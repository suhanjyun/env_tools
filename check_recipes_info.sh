pushd ${PWD}
  echo "Actual use recipe ${1} info:"
  #bitbake -e ${1} | grep -E "^PV|^FILE=|^PR"
  bitbake -e ${1} | grep -E "^PV|^FILE="
  echo "done"
popd
