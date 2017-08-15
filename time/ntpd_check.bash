#!/bin/bash

LOG_LEVEL=1
LOG_FILE=/tmp/ntp-trace.log
SERVER="#servername#"
UPDATE_TIME_SERVERS=FALSE
CURRENT_DATE=$(date +'%Y-%m-%d %H:%M:%S')

if [[ ! -z ${1} ]]; then
  SERVER="${1}"
fi

if [[ ! -z ${2} ]]; then
  if [[ ${2} == TRUE ]]; then
    UPDATE_TIME_SERVERS=TRUE
  fi
fi

if [[ ! -z ${3} ]]; then
  LOG_LEVEL=${3}
fi

exec 3>&1 1>>${LOG_FILE} 2>&1

NTP_INSTALLED=`sudo service --status-all | grep "ntp"`
if [[ ! -z ${NTP_INSTALLED} ]]; then
    NTP_STATUS=`ntpstat | grep sync`
    if [[ ${NTP_STATUS} == *"unsync"* ]]; then
        echo "[WARNING] ${SERVER} | ${CURRENT_DATE} | ${NTP_INSTALLED} | ${NTP_STATUS}" | tee /dev/fd/3
    else
        if [[ ${NTP_INSTALLED} == *"stopped"* ]]; then
            echo "[WARNING] ${SERVER} | ${CURRENT_DATE} | ${NTP_INSTALLED}"  | tee /dev/fd/3
        else
            echo "[INFO]    ${SERVER} | ${CURRENT_DATE} | ${NTP_INSTALLED} | ${NTP_STATUS}" | tee /dev/fd/3
        fi
    fi
    if [[ ${UPDATE_TIME_SERVERS} == TRUE ]]; then
        service restart
    fi
else
    if [[ -z ${NTP_INSTALLED} ]]; then
        NTP_INSTALLED="NTPD is NOT installed"
    fi
    echo "[ERROR]   ${SERVER} | ${CURRENT_DATE} | ${NTP_INSTALLED}" | tee /dev/fd/3
fi
