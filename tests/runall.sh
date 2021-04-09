#!/bin/bash

source functions.sh

export setenv_debug="${setenv_debug:-1}"
export setenv_noprompt="${setenv_noprompt:-1}"

tests=("it_creates_symlinks" "it_creates_backups")

for test in ${tests[*]}; do
    echo "**********************************"
    echo "${test}"
    echo "**********************************"
    ( cd ${test} ; source test.sh )
done
