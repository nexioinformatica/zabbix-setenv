# Boolean `true`. In bash is reversed as 0 means OK.
tt=0

# Boolean `false`. In bash is reversed as 1 means not-OK.
ff=1

# Prints a debug string if `setenv_debug` env var is setted.
# $1: The string to print
debug() {
    if [ ${setenv_debug} -eq 1 ]; then
        echo "[DEBUG] $1"
    fi
}

# Checks if file exists or not
# $1: The path to file
check_file_exists() {
    if [ -f "$1" ]; then
        return "${tt}"
    fi

    return "${ff}"
}

# Ask to user whether to proceed or not
# Returns false if desicion is "no", true otherwise
ask_proceed() {
    read -p "Are you sure you want to proceed? [y/n] " decision
    if [[ ! "${decision}" =~ ^[Yy]$ ]]; then
        return "${ff}"
    fi

    return "${tt}"
}
