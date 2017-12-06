#!/bin/bash

function read_config() {

    SQL_USER=
    SQL_PASSWORD=
    SQL_SCHEMA=
    SQL_HOST=
    SQL_PORT=3306

    PROPERTY_FILE=${1}

    echo "***************************************************************"
    echo "* Determine configuration                                     *"
    echo "***************************************************************"

    if [ -f "${PROPERTY_FILE}" ]
    then
        echo "[INFO] ${PROPERTY_FILE} found"

        while IFS='=' read -r key value
            do
                key=$(echo ${key} | tr '.' '_')
                eval "${key}='${value}'"
            done < "${PROPERTY_FILE}"

        if [[ ! -z ${SQL_USER} ]]; then
            echo "[INFO] Export SQL_USER="${SQL_USER}
            export SQL_USER=${SQL_USER}
        fi
        if [[ ! -z ${SQL_PASSWORD} ]]; then
            echo "[INFO] Export SQL_PASSWORD=********"
            export SQL_PASSWORD=${SQL_PASSWORD}
        fi
        if [[ ! -z ${SQL_SCHEMA} ]]; then
            echo "[INFO] Export SQL_SCHEMA="${SQL_SCHEMA}
            export SQL_SCHEMA=${SQL_SCHEMA}
        fi
        if [[ ! -z ${SQL_HOST} ]]; then
            echo "[INFO] Export SQL_HOST="${SQL_HOST}
            export SQL_HOST=${SQL_HOST}
        fi
        if [[ ! -z ${SQL_HOST} ]]; then
            echo "[INFO] Export SQL_PORT="${SQL_PORT}
            export SQL_PORT=${SQL_PORT}
        fi
    else
        echo "[ERROR] ${PROPERTY_FILE} not found"
        exit 1
    fi
}