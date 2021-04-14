check_file_exists() {
    if [ ! -f "$1" ]; then
        echo "$1 not found"
        return 1
    fi

    return 0
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

pp() {
    if [ "$2" -eq 1 ]; then
        printf "FAIL: "
    else
        printf "SUCCESS: "
    fi

    printf "$1\n"
}

stop() {
    if [ $1 -eq 0 ]; then
        exit 0
    fi

    exit 1
}
