#!/bin/bash

source "`pwd`/functions.sh"

main_script="`pwd`/../utils.sh"

export setenv_root="`pwd`/.."

it_prints_debug_strings_if_enabled() {
    setup() {
        export setenv_debug=1
    }

    teardown() {
        unset setenv_debug
    }

    setup

    source "${main_script}"

    return_value=$(debug "Hello, World!")
    return_code=$?

    [ "${setenv_debug}" -eq "1" ] && echo "${return_value}"

    is_nonempty_string "${return_value}"
    expected_ok=$?

    pp "${expected_ok}" "it prints debug strings if enabled"

    teardown

    return ${expected_ok}
}

it_does_not_print_debug_strings_when_disabled() {
    setup() {
        export setenv_debug=0
    }

    teardown() {
        unset setenv_debug
    }

    setup

    source "${main_script}"

    return_value=$(debug "Hello, World!")
    return_code=$?

    [ "${setenv_debug}" -eq "1" ] && echo "${return_value}"

    is_empty_string "${return_value}"
    expected_ok=$?

    pp "${expected_ok}" "it does not print debug strings when disabled"

    teardown

    return "${expected_ok}"
}

it_returns_true_if_file_exists() {
    setup() {
        filepath="/tmp/file.txt"

        touch "${filepath}"
    }

    teardown() {
        rm "${filepath}"
    }

    setup

    source "${main_script}"

    return_value=$(check_file_exists "${filepath}")
    return_code="$?"

    [ "${setenv_debug}" -eq "1" ] && echo "${return_value}"

    is_true "${return_code}"
    expected_ok="$?"

    pp "${expected_ok}" "it returns true if file exists"

    teardown

    return "${expected_ok}"
}


it_returns_false_if_file_does_not_exists() {
    setup() {
        filepath="/tmp/file.txt"
    }
    teardown() {
        skip
    }

    setup

    source "${main_script}"

    return_value=$(check_file_exists "${filepath}")
    return_code="$?"

    [ "${setenv_debug}" -eq "1" ] && echo "${return_value}"

    is_false "${return_code}"
    expected_ok="$?"

    pp "${expected_ok}" "it returns false if file does not exists"

    teardown

    return "${expected_ok}"
}


it_returns_true_when_user_wants_to_proceed() {
    setup() {
        skip
    }
    teardown() {
        skip
    }

    setup

    source "${main_script}"

    return_value=$(yes | ask_proceed)
    return_code="$?"

    [ "${setenv_debug}" -eq "1" ] && echo "${return_value}"

    is_true "${return_code}"
    expected_ok="$?"

    pp "${expected_ok}" "it returns true when user wants to proceed"

    teardown

    return "${expected_ok}"
}
