# Gets one available command from the string divided by a colon
__enhancd::core::get_filter_command()
{
    local item str

    if [[ -z ${1} ]]; then
        return 1
    fi

    # str should be list like "a:b:c" concatenated by a colon
    str="${1}:"

    while [[ -n ${str} ]]; do
        # the first remaining entry
        item=${str%%:*}
        # reset str
        str=${str#*:}

        if __enhancd::command::which "${item%% *}"; then
            echo "${item}"
            return 0
        else
            continue
        fi
    done

    return 1
}

# Returns true if enhancd is ready to be available
__enhancd::core::is_available()
{
    __enhancd::core::get_filter_command "${ENHANCD_FILTER}" \
        &>/dev/null && [[ -s ${ENHANCD_DIR}/enhancd.log ]]
    return ${?}
}
