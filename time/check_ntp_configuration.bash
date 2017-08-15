#!/bin/bash

LOG_LEVEL=1
LOG_FILE=/tmp/ntp-trace.log
SERVER_IDS_BEGIN=
SERVER_IDS_END=
SERVER_USERNAME=
SERVER_HOSTNAME=

RUNAS=

UPDATE_TIME_SERVERS=FALSE
CURRENT_DATE=$(date +'%Y-%m-%d %H:%M:%S')

function help() {
  echo "*********************************************************************"
  echo "* Usage                                                             *"
  echo "*********************************************************************"
  echo "* Please specify a range of servers you want to check               *"
  echo "* You can do this with:                                             *"
  echo "* + -b = SERVER_IDS_BEGIN                                           *"
  echo "* + -e = SERVER_IDS_END                                             *"
  echo "* + -u = SERVER_USERNAME                                            *"
  echo "* + -h = SERVER_HOSTNAME (with placeholders)                        *"
  echo "*        e.g. hostname #id# .example.example.com                    *"
  echo "* Enter the name of the user you want to use to run this script     *"
  echo "* + -r = RUNAS                                                      *"
  echo "* Extra options concerning logging and updating time configuration  *"
  echo "* + -l = LOG_LEVEL                                              *"
  echo "* + -r = UPDATE_TIME_SERVERS                                        *"
  echo "* For example: ./check_ntp_configuration.bash -b 0 -e 99 -r shaakma *"
  echo "*********************************************************************"
}


exec 3>&1 1>>${LOG_FILE} 2>&1

if [ $# -eq 0 ]; then
    help
    exit 1
fi

while getopts :h:b:e:u:r:su:l opt; do
    case ${opt} in
        h) SERVER_HOSTNAME=${OPTARG}
        ;;
        b) SERVER_IDS_BEGIN=${OPTARG}
        ;;
        e) SERVER_IDS_END=${OPTARG}
        ;;
        u) SERVER_USERNAME=${OPTARG}
        ;;
        r) RUNAS=${OPTARG}
        ;;
        u) UPDATE_TIME_SERVERS=TRUE
        ;;
        l) LOG_LEVEL=${OPTARG}
        ;;
        :) echo "Missing argument for option -${OPTARG}"; exit 1
        ;;
       \?) echo "Unknown option -${OPTARG}"; exit 1
        ;;
    esac
done

echo "[INFO]    current time (on my execution environment): ${CURRENT_DATE}"
for serverId in $(seq  -f "%02g" ${SERVER_IDS_BEGIN} ${SERVER_IDS_END});
do
    SERVER_DOMAIN=`echo ${SERVER_HOSTNAME} | sed -e "s/\#id\#/${serverId}/"`
    if [[ ${LOG_LEVEL} == 5 ]]; then
      echo "[DEBUG]   ssh -o StrictHostKeyChecking=no ${SERVER_USERNAME}@${SERVER_DOMAIN} 'cat | bash /dev/stdin' \"${SERVER_DOMAIN}\" < \"ntpd_check.bash\"  | tee /dev/fd/3"
    fi
    ssh -o StrictHostKeyChecking=no ${SERVER_USERNAME}@${SERVER_DOMAIN} 'cat | bash /dev/stdin' "${SERVER_DOMAIN}" "${UPDATE_TIME_SERVERS}" "${LOG_LEVEL}" < "ntpd_check.bash"
done