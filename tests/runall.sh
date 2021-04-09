#!/bin/bash

source functions.sh

export setenv_debug="${setenv_debug:-1}"
export setenv_noprompt="${setenv_noprompt:-1}"

tests=("it_creates_symlinks" "it_creates_backups")

for test in ${tests[*]}; do
    [ ${setenv_debug} -eq 1 ] && echo "****************************"
    [ ${setenv_debug} -eq 1 ] && echo "${test}"
    [ ${setenv_debug} -eq 1 ] && echo "****************************"
    ( cd ${test} ; source test.sh )
    [ ${setenv_debug} -eq 1 ] && echo ""
done
