setenv_noprompt="${setenv_noprompt:-0}"
setenv_debug="${setenv_debug:-0}"

if [ ${setenv_debug} -eq 1 ]; then
    echo "debug is enabled"
fi

data_folder_fn="zbx_env"

env_root="${env_root:-`pwd`}"
env_data_filepath="${env_data_filepath:-${env_root}/${data_folder_fn}}"

now="$(date +"%Y%m%d%H%M%S")"

out_file="${out_file:-${data_folder_fn}_${now}.tar.gz}"

# enable tar verbose mode if `setenv_debug` = 1
[ ${setenv_debug} -eq 1 ] && v="-v" || v=""

if [ ${setenv_debug} -eq 1 ]; then
    echo "out file = ${out_file}"
    echo "diname   = `dirname ${env_data_filepath}`"
    echo "basename = `basename ${env_data_filepath}`"
fi

# Create and zip an archive with filename `out_file` for `env_data_filepath`.
# Also, do not store full path.
tar -cz ${v} -f ${out_file} -C "`dirname ${env_data_filepath}`" "`basename ${env_data_filepath}`"
