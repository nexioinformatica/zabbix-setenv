#!/bin/bash

export setenv_debug=1
export setenv_noprompt=1

tests=("it_creates_symlinks")

for test in "${tests}"; do
    echo "**********************************"
    echo "${test}"
    echo "**********************************"
    cd ${test} && source test.sh
    echo ""
done
