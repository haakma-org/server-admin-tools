#!/bin/bash

SERVER_IDS_BEGIN=
SERVER_IDS_END=
SERVER_USERNAME=
RUNAS=
LOG_TO_SCREEN=FALSE
UPDATE_TIME_SERVERS=FALSE

function help() {
  echo "*********************************************************************"
  echo "* Usage                                                             *"
  echo "*********************************************************************"
  echo "* Please specify a range of servers you want to check               *"
  echo "* You can do this with:                                             *"
  echo "* + -b = SERVER_IDS_BEGIN                                           *"
  echo "* + -e = SERVER_IDS_END                                             *"
  echo "* Enter the name of the user you want to use to run this script     *"
  echo "* + -r = RUNAS                                                      *"
  echo "* For example: ./check_ntp_configuration.bash -b 0 -e 99 -r shaakma *"
  echo "*********************************************************************"
}

if [ $# -eq 0 ]; then
    help
    exit 1
fi

while getopts :hb:e:n:r:su opt; do
    case ${opt} in
        h) help; exit
        ;;
        b) SERVER_IDS_BEGIN=${OPTARG}
        ;;
        e) SERVER_IDS_END=${OPTARG}
        ;;
        n) SERVER_USERNAME=${OPTARG}
        ;;
        r) RUNAS=${OPTARG}
        ;;
        s) LOG_TO_SCREEN=TRUE
        ;;
        u) UPDATE_TIME_SERVERS=TRUE
        ;;
        :) echo "Missing argument for option -${OPTARG}"; exit 1
        ;;
       \?) echo "Unknown option -${OPTARG}"; exit 1
        ;;
    esac
done

echo "CURRENT TIME (on my execution environment): `date`"
for serverId in $(seq  -f "%02g" ${SERVER_IDS_BEGIN} ${SERVER_IDS_END});ß
do
    SERVER_URL=${serverId}
    echo "[DEBUG] ssh -o StrictHostKeyChecking=no  ${SERVER_USERNAME}@${serverUrl} 'cat | bash /dev/stdin' \"${serverUrl}\" < \"ntpd_check.bash\" >> /tmp/ntp.log"
    if [[ ${LOG_TO_SCREEN} == FALSE ]]; then
        ssh -o StrictHostKeyChecking=no ${SERVER_USERNAME}@${SERVER_URL} 'cat | bash /dev/stdin' "${SERVER_URL}" "${UPDATE_TIME_SERVERS}" < "ntpd_check.bash" >> /tmp/ntp-debug.log
    else
        ssh -o StrictHostKeyChecking=no ${SERVER_USERNAME}@#${SERVER_URL} 'cat | bash /dev/stdin' "${SERVER_URL}" "${UPDATE_TIME_SERVERS}" < "ntpd_check.bash"
    fi
done