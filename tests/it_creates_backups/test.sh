#!/bin/bash

# Checks whether a backup is created with extension .tar.gz

setup() {
    res="`pwd`/res"
    main_script="`pwd`/../../backup.sh"

    export env_root="${res}"
    export out_file="${res}/zbx_env_00000000000000.tar.gz"

    rm -f "${out_file}"
}

it_creates_targz_backup() {
    setup
    source "${main_script}"

    file_tests=("${out_file}")

    all check_file_exists $file_tests
    outcome=$?

    pp ${outcome} "it creates .tar.gz backup"

    stop "${outcome}"
}

it_creates_targz_backup
