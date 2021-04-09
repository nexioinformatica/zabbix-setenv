#!/bin/bash

setup() {
    export env_root="`pwd`/source"
    export zbx_root="`pwd`/target"

    main_script="`pwd`/../../setenv.sh"
}

it_creates_symlinks() {
    setup
    source "${main_script}"

    file_tests=("${zbx_root}/docker-compose.yaml" "${zbx_root}/.POSTGRES_PASSWORD" "${zbx_root}/zbx_env/data.txt")

    all check_file_exists $file_tests
    outcome=$?

    pp "it creates symlinks" ${outcome}

    stop "${outcome}"
}

it_creates_symlinks
