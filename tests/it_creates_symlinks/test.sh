#!/bin/bash

check_file_exists() {
    if [ ! -f "$1" ]; then
        echo "$1 not found"
        return 1
    fi

    return 0
}

export env_root="`pwd`/source"
export zbx_root="`pwd`/target"

main_script="`pwd`/../../setenv.sh"

## MAIN

source "${main_script}"

file_tests=("${zbx_root}/docker-compose.yaml" "${zbx_root}/.POSTGRES_PASSWORD" "${zbx_root}/zbx_env/data.txt")
ok=0

for f_test in ${file_tests[*]}; do
    check_file_exists "${f_test}"
    is_error=$?

    if [ "${is_error}" -eq 1 ]; then
        echo "FAIL"
        exit 1
    fi
done

echo "SUCCESS"
