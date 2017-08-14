#!/bin/bash

SERVER="#servername#"
UPDATE_TIME_SERVERS=FALSE

if [[ ! -z ${1} ]]; then
  SERVER="ß${1}"
fi

if [[ ! -z ${2} ]]; then
  if [[ ${2} == TRUE ]]; then
    UPDATE_TIME_SERVERS=TRUE
  fi
fi


echo "* ${SERVER} : `date` *"
echo "----------------------------------------"
if sudo service --status-all | grep 'ntp'; then
  ntpstat
  if [[ ${UPDATE_TIME_SERVERS} == TRUE ]]; then
    service restart
  fi
else
  echo "ntpd is not installed"
fi
echo "****************************************"