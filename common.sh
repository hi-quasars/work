#!/bin/bash
pr_info()
{
    type=$2
    if [ "${type}" = "" ]; then
        type="info"
    fi

    case ${type} in
        info )
            echo -e "\033[32m[ info ] $1\033[0m"
            ;;
        warn )
            echo -e "\033[33m[ warn ] $1\033[0m"
            ;;
        error )
            echo -e "\033[31m[ error] $1\033[0m"
            ;;
    esac
}

