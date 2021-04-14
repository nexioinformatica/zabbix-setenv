#!/bin/bash

source ../functions.sh

setup() {
    export setenv_use_defaults=0

    main_script="`pwd`/../../setenv.sh"
}

it_fails_creating_symlinks_if_no_defaults_and_no_values() {
    setup

    output=$("${main_script}")
    outcome=$?

    echo "${output}"

    expect_fail "it fails creating symlinks if no defaults and no values" ${outcome}

    stop "${outcome}"
}

it_fails_creating_symlinks_if_no_defaults_and_no_values
