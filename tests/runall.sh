#!/bin/bash

source "`pwd`/functions.sh"

setenv_debug="${setenv_debug:-0}"
setenv_verbose="${setenv_verbose:-1}"

runall() {
    ok="${tt}"

    utils_suite="utils.test.sh"
    utils_tests=("it_prints_debug_strings_if_enabled" "it_does_not_print_debug_strings_when_disabled" "it_returns_true_if_file_exists" "it_returns_false_if_file_does_not_exists" "it_returns_true_when_user_wants_to_proceed")

    runsuite "${utils_suite}" "${utils_tests[@]}"
    [ "$?" == "${ff}" ] && ok="${ff}"

    setenv_suite="setenv.test.sh"
    setenv_tests=("it_symlinks_all_content_in_folder" "it_fails_creating_symlinks_if_no_defaults")

    runsuite "${setenv_suite}" "${setenv_tests[@]}"
    [ "$?" == "${ff}" ] && ok="${ff}"

    backup_suite="backup.test.sh"
    backup_tests=("it_creates_targz_backups")

    runsuite "${backup_suite}" "${backup_tests[@]}"
    [ "$?" == "${ff}" ] && ok="${ff}"

    echo "----------------------------------------------------------------------"

    if [ "${ok}" = "${tt}" ]; then
        echo "OK"
        return "${tt}"
    else
        echo "Completed with errors!"
        return "${ff}"
    fi
}

runsuite() {
    local suite_script="$1"
    shift
    local suite_tests=("$@")

    source "${suite_script}"

    echo "######################################################################"
    echo "# Suite ${suite_script}"
    echo "######################################################################"

    local n_tests=0
    local n_failed=0

    for test in "${suite_tests[@]}"; do
        output=$("${test}")
        outcome="$?"

        if [ "${setenv_verbose}" = "1" ]; then echo "${output}"; fi
        if [ "${setenv_debug}" = "1" ]; then echo "${outcome}"; fi

        if [ "${outcome}" = "${ff}" ]; then
            n_failed=$(("${n_failed}" + 1))
        fi
        n_tests=$(("${n_tests}" + 1))
    done

    local n_ok=$(("${n_tests}" - "${n_failed}"))

    echo "Passed ${n_ok} of ${n_tests} tests, ${n_failed} failed."

    if [ "${n_failed}" -gt "0" ]; then
        return 1
    fi
    return 0
}

runall
