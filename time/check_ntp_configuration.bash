#!/bin/bash

SERVER_IDS_BEGIN=
SERVER_IDS_END=
RUNAS=

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

while getopts :hb:e:r: opt; do
    case ${opt} in
        h) help; exit
        ;;
        b) SERVER_IDS_BEGIN=${OPTARG}
        ;;
        e) SERVER_IDS_END=${OPTARG}
        ;;
        r) RUNAS=${OPTARG}
        ;;
        :) echo "Missing argument for option -${OPTARG}"; exit 1
        ;;
       \?) echo "Unknown option -${OPTARG}"; exit 1
        ;;
    esac
done

echo "CURRENT TIME (on my execution environment): `date`"
for serverId in $(seq  -f "%02g" ${SERVER_IDS_BEGIN} ${SERVER_IDS_END});
do
    echo "[DEBUG] ssh -J umcg-${RUNAS}@lobby.hpc.rug.nl molgenis@molgenis${serverId}.gcc.rug.nl 'echo molgenis${serverId} : `date`'"
    ssh -J umcg-${RUNAS}@lobby.hpc.rug.nl molgenis@molgenis${serverId}.gcc.rug.nl "echo molgenis${serverId} : `date`" >> ntp.log
done