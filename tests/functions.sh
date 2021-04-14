tt=0

ff=1

check_file_exists() {
    if [ ! -f "$1" ]; then
        echo "$1 not found"
        return 1
    fi

    return 0
}

skip() {
    return "${tt}"
}

# $1: the predicate `pred` to execute on each element of the list
# $2: the list `xs`
# Return 0 if `pred` is true on all elements of xs, 1 otherwise
all() {
    local pred=$1
    local xs=$2

    for x in ${xs[*]}; do
        ${pred} "${x}"
        local is_error=$?

        if [ "${is_error}" -eq 1 ]; then
            return 1
        fi
    done

    return 0
}

expect_fail() {
    if [ "$2" -eq 0 ]; then
        printf "FAIL: "
    else
        printf "SUCCESS: "
    fi

    printf "$1\n"
}

is_true() {
    if [ "$1" = "${tt}" ]; then
        return "${tt}"
    fi

    return "${ff}"
}

is_false() {
    if [ "$1" = "${ff}" ]; then
        return "${tt}"
    fi

    return "${ff}"
}

is_empty_string() {
    if [ -z "$1" ]; then
        return "${tt}"
    else
        return "${ff}"
    fi
}

is_nonempty_string() {
    if [ -z "$1" ]; then
        return "${ff}"
    else
        return "${tt}"
    fi
}

pp() {
    if [ "$1" = "${tt}" ]; then
        printf "SUCCESS: "
    else
        printf "FAIL: "
    fi

    printf "$2\n"
}

stop() {
    if [ $1 -eq 0 ]; then
        exit 0
    fi

    exit 1
}
