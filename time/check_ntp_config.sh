#!/bin/bash


SERVER_IDS_BEGIN=
SERVER_IDS_END=

function help() {
  echo "Please specify a range of servers you want to check"
  echo "You can do this with:"
  echo " * -b = BEGIN"
  echo " * -e = END"
  echo "For example: ./check_ntp_config.sh -b 0 -e 99"
}

while getopts :hb:e: opt; do
    case ${opt} in
        h) help; exit
        ;;
        b) SERVER_IDS_BEGIN=${OPTARG}
        ;;
        e) SERVER_IDS_END=${OPTARG}
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
    echo "[DEBUG] ssh lobby+molgenis${serverId}.gcc.rug.nl 'echo molgenis${serverId} : `date`'"
    ssh lobby+molgenis${serverId}.gcc.rug.nl "echo molgenis${serverId} : `date`" >> ntp.log
done