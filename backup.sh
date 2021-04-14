setenv_noprompt="${setenv_noprompt:-0}"
setenv_debug="${setenv_debug:-0}"
setenv_root="${setenv_root:-`pwd`}"

# MAIN

source "${setenv_root}/utils.sh"

source_root="${source_root:-`pwd`/source}"
target_root="${target_root:-`pwd`/target}"

now="$(date +"%Y%m%d%H%M%S")"

out_file="${out_file:-${target_root}/${backup}_${now}.tar.gz}"

# enable tar verbose mode if `setenv_debug` = 1
[ "${setenv_debug}" -eq "1" ] && v="-v" || v=""

if [ "${setenv_debug}" -eq "1" ]; then
    debug "out file = ${out_file}"
    debug "diname   = `dirname ${source_root}`"
    debug "basename = `basename ${source_root}`"
fi

debug "Creating .tar.gz archive"

# Create and zip an archive with filename `out_file` for `env_data_filepath`.
# Also, do not store full path.
tar -cz ${v} -f ${out_file} -C "`dirname ${source_root}`" "`basename ${source_root}`"
