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

setenv_noprompt="${setenv_noprompt:-0}"
setenv_debug="${setenv_debug:-0}"

passwd_fn=".POSTGRES_PASSWORD"
data_folder_fn="zbx_env"
docker_compose_f="docker-compose_v3_ubuntu_pgsql_latest.yaml"

env_root="${env_root:-`pwd`}"
env_passwd_filepath="${env_passwd_filepath:-${env_root}/${passwd_fn}}"
env_data_filepath="${env_data_filepath:-${env_root}/${data_folder_fn}}"

zbx_root="${zbx_root:-`pwd`/zabbix-docker}"
zbx_passwd_filepath="${zbx_passwd_filepath:-${zbx_root}/${passwd_fn}}"
zbx_data_filepath="${zbx_data_filepath:-${zbx_root}/${data_folder_fn}}"

if [ ${setenv_debug} -eq 1 ]; then
    echo "debug is enabled"
    echo "env root   = ${env_root}"
    echo "env passwd = ${env_passwd_filepath}"
    echo "env data   = ${env_data_filepath}"
    echo "zbx root   = ${zbx_root}"
    echo "zbx passwd = ${zbx_passwd_filepath}"
    echo "zbx data   = ${zbx_data_filepath}"
fi

# do some checks before deleting configs to prevent loss of data

if [ ! -f "$env_passwd_filepath" ]; then
    echo "ERROR: $env_passwd_filepath does not exists."
    exit 1
fi
if [ ! -d "$env_data_filepath" ]; then
    echo "ERROR: $env_data_filepath does not exists."
    exit 1
fi

# 1. delete previous configuration

if [ ${setenv_noprompt} -eq 0 ]; then
    echo "The following entries will be deleted"
    echo "* ${zbx_passwd_filepath}"
    echo "* ${zbx_data_filepath}"
    echo "* ${zbx_root}/docker-compose.yaml"
    read -p "Are you sure you want to proceed? [y/n] "
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        exit 0
    fi
fi

rm -f "${zbx_passwd_filepath}"
rm -rf "${zbx_data_filepath}"
rm -f "${zbx_root}/docker-compose.yaml"

# 2. generate new configuration

ln -s "${env_passwd_filepath}" "${zbx_passwd_filepath}"
ln -s "${env_data_filepath}" "${zbx_data_filepath}"
ln -s "${env_root}/${docker_compose_f}" "${zbx_root}/docker-compose.yaml"
