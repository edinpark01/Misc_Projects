#!/bin/bash

get_plugins() {
    while read plugin
        do
            plugins="${plugins}:${plugin}"
        done < $1

    echo ${plugins}
}

get_uninstalled_plugins() {
    while IFS=':' read -ra ADD
        do
            for i in "${ADD[@]}"
            do
                is_installed=$( ls ./installed_plugins/ | egrep  ^${i}$ )
                [[ ${#i} -ne 0 ]] && [[ ${#is_installed} -eq 0 ]] && echo "${i}: Not Installed"
                [[ ${#i} -ne 0 ]] && [[ ${#is_installed} -nq 0 ]] && echo "${i}: Installed"
            done
        done <<< "${1}"
}

OLDIFS=$IFS
IFS=","

export REQUIRED_PLUGINS=$( get_plugins ${1} )

get_uninstalled_plugins ${REQUIRED_PLUGINS}

IFS=$OLDIFS
