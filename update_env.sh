#!/bin/bash

PID=$1
VAR_NAME=$2
NEW_VALUE=$3

if [[ ! "$PID" =~ ^[0-9]+$             || \
      ! "$VAR_NAME" =~ ^[0-9A-Za-z_]+$ || \
      ! "$NEW_VALUE" =~ ^[0-9]+$ ]]
then
    echo "USAGE: $(basename $0) <pid> <env-var-name> <new-value>" >&2
    exit 1
fi

if gdb -p $PID                                   \
       -ex 'source update_env.py'                \
       -ex "update_env ${VAR_NAME}=${NEW_VALUE}" \
       -ex 'detach'                              \
       -ex 'quit' >/dev/null
then
    echo -e "\033[32;1mUpdated ${VAR_NAME} to ${NEW_VALUE} for PID ${PID}.\033[0m"
else
    echo -e "\033[31;1mFailed to update ${VAR_NAME} to ${NEW_VALUE} for PID ${PID}.\033[0m"
fi
