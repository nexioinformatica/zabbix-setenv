main_script="`pwd`/../setenv.sh"

export setenv_root="`pwd`/.."

it_symlinks_all_content_in_folder() {
    setup() {
        export source_root="/tmp/setenv/source"
        export target_root="/tmp/setenv/target"

        mkdir -p "${source_root}"
        mkdir -p "${target_root}"

        f1="${source_root}/.hidden-file"
        f2="${source_root}/visible-file"

        test_files=("${f1}" "${f2}")

        touch "${f1}"
        touch "${f2}"
    }

    teardown() {
        skip
    }

    setup

    source "${main_script}"

    return_value=$(all check_file_exists ${test_files})
    return_code="$?"

    [ "${setenv_debug}" -eq "1" ] && echo "${return_value}"

    is_true "${return_code}"
    expected_ok="$?"

    pp "${expected_ok}" "it symlinks all content in folder"

    teardown

    return "${expected_ok}"
}

it_fails_creating_symlinks_if_no_defaults() {
    setup() {
        skip
    }

    teardown() {
        skip
    }

    setup

    return_value=$("${main_script}")
    return_code="$?"

    [ "${setenv_debug}" -eq "1" ] && echo "${return_value}"

    is_false "${return_code}"
    expected_ok="$?"

    pp "${expected_ok}" "it fails creating symlinks if no defaults"

    teardown

    return "${expected_ok}"
}
