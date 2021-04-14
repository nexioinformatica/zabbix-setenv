#!/bin/bash

source ../functions.sh

setup() {
    export source_root="`pwd`/res/source"
    export target_root="`pwd`/res/target"

    main_script="`pwd`/../../setenv.sh"
}

it_creates_symlinks() {
    setup
    source "${main_script}"

    file_tests=("${target_root}/docker-compose.yaml" "${target_root}/.POSTGRES_PASSWORD" "${target_root}/zbx_env/data.txt")

    all check_file_exists $file_tests
    outcome=$?

    pp ${outcome} "it creates symlinks"

    stop "${outcome}"
}

it_creates_symlinks
