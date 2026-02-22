showtaskrp="showtaskrp.log"
pushd ${PWD}
  rm -rf ${showtaskrp}
  touch ${showtaskrp}
  echo "Example: showtaskrp busybox"
  echo "bitbake ${1} -c listtasks"
  bitbake ${1} -c listtasks > ${showtaskrp}
  cat ${showtaskrp}
popd

