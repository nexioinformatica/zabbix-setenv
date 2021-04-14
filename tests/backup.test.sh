main_script="`pwd`/../backup.sh"

export setenv_root="`pwd`/.."

it_creates_targz_backups() {
    setup() {
        local rnd="${RANDOM}"
        export source_root="/tmp/setenv${rnd}/source"
        export target_root="/tmp/setenv${rnd}"
        export out_file="${target_root}/backup_00000000000000.tar.gz"

        mkdir -p "${source_root}"

        f1="${source_root}/.hidden-file"
        f2="${source_root}/visible-file"

        test_files=("${f1}" "${f2}")

        echo "f1" > "${f1}"
        echo "f2" > "${f2}"
    }

    teardown() {
        skip
    }

    setup

    return_value=$("${main_script}")
    return_code="$?"

    [ "${setenv_debug}" -eq "1" ] && echo "${return_value}"

    check_file_exists "${out_file}"
    expected_ok="$?"

    pp "${expected_ok}" "it creates targz backups"

    teardown

    return "${expected_ok}"
}
