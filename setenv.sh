#!/bin/bash

# This scripts generates secrets and setup the environment for zabbix
# execution.
#
# The script does the following.
#
# * Symlink `.POSTGRES_PASSWORD`
# * Symlink `zbx_env` folder
# * Symlink `docker-compose_v3_ubuntu_pgsql_latest.yaml` to `docker-compose.yaml`
#
# Usage
# -----
#
# You can override the script behaviour by changing path to files both
# in env and zbx path. Variables must be exported with the fully qualified
# name of a file.
#
# Please take a look at the docs for further informations:
#

print_must_define_variables() {
    echo "You must define variable values. Take a look at README.md for further"
    echo "details."
}

print_debug() {
    debug "setenv_debug = ${setenv_debug}"
    debug "setenv_noprompt = ${setenv_noprompt}"
    debug "setenv_use_defaults = ${setenv_use_defaults}"
}

check_defaults_usage() {
    if [ ${setenv_use_defaults} -eq 0 ]; then
        if [ -z "${source_root}" ] || [ -z "${target_root}" ]; then
            print_must_define_variables
            exit 1
        fi
    fi
}

check_source_root_content() {
    if [ ! -d "${source_root}" ] || [ -z "$(ls -A ${source_root})" ]; then
        if [ "${setenv_noprompt}" -eq 0 ]; then
            echo "Either the source directory does not exists or is empty."
            ask_proceed
        fi
    fi
}

check_target_root_content() {
    if [ -d "${target_root}" ]; then
        if [ "${setenv_noprompt}" -eq 0 ]; then
            echo "The target directory is not empty."
            ask_proceed
        fi
    fi
}

setenv_noprompt="${setenv_noprompt:-0}"
setenv_debug="${setenv_debug:-0}"
setenv_use_defaults="${setenv_use_defaults:-0}"
setenv_root="${setenv_root:-`pwd`}"
# setenv_allowlist="${setenv_allowlist:-""}"
# setenv_denylist="${setenv_denylist:-""}"

# MAIN

source "${setenv_root}/utils.sh"

print_debug

check_defaults_usage

source_root="${source_root:-`pwd`/source}"
target_root="${target_root:-`pwd`/target}"

debug "source_root = ${source_root}"
debug "target_root = ${target_root}"

check_source_root_content
check_target_root_content

find ${source_root} -mindepth 1 -maxdepth 1 -printf "%f\n" | while read source_basename

do
    source_file="${source_root}/${source_basename}"
    target_file="${target_root}/${source_basename}"

    rm -rf "${target_file}"
    debug "Removed ${target_file}"

    ln -s "${source_file}" "${target_file}"
    debug "Symlinked ${source_file} to ${target_file}"
done
