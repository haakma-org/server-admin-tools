#!/bin/bash

SERVER_IDS_BEGIN=
SERVER_IDS_END=
RUNAS=
PUBLIC_KEY=
TARGET_USER=

function help() {
  echo "*******************************************************************************************************************************************"
  echo "* Usage                                                                                                                                   *"
  echo "*******************************************************************************************************************************************"
  echo "* Please specify a range of servers you want to check                                                                                     *"
  echo "* You can do this with:                                                                                                                   *"
  echo "* + -b = SERVER_IDS_BEGIN                                                                                                                 *"
  echo "* + -e = SERVER_IDS_END                                                                                                                   *"
  echo "* Enter the user you want to run this script                                                                                              *"
  echo "* + -r = RUNAS                                                                                                                            *"
  echo "* Enter the target username                                                                                                               *"
  echo "* + -t = TARGET_USER                                                                                                                      *"
  echo "* Enter the target users public key you want to create on the target servers                                                              *"
  echo "* + -p = PUBLIC_KEY                                                                                                                       *"
  echo "* For example: ./create_public_key_on_servers.bash -b 0 -e 99 -r shaakma -t shaakma -p "ssh-rsa khnjasljkbdfkvelkkasBCSJHLDCVDBQF234875Y" *"
  echo "*******************************************************************************************************************************************"
}

if [ $# -eq 0 ]; then
    help
    exit 1
fi

while getopts :hb:e:r:p:t: opt; do
    case ${opt} in
        h) help; exit
        ;;
        b) SERVER_IDS_BEGIN=${OPTARG}
        ;;
        e) SERVER_IDS_END=${OPTARG}
        ;;
        r) RUNAS=${OPTARG}
        ;;
        p) PUBLIC_KEY=${OPTARG}
        ;;
        t) TARGET_USER=${OPTARG}
        ;;
        :) echo "Missing argument for option -${OPTARG}"; exit 1
        ;;
       \?) echo "Unknown option -${OPTARG}"; exit 1
        ;;
    esac
done

echo "Script will be run as: [ ${RUNAS} ] for target user: [ ${TARGET_USER} ] on the servers: [ ${SERVER_IDS_BEGIN} ] - [ ${SERVER_IDS_END} ]"

for serverId in $(seq  -f "%02g" ${SERVER_IDS_BEGIN} ${SERVER_IDS_END});
do
    echo "[DEBUG] ssh -J umcg-${RUNAS}@lobby.hpc.rug.nl molgenis@molgenis${serverId}.gcc.rug.nl '>> ${TARGET_USER} ~/.ssh/authorized_keys'"
    echo "[DEBUG] ssh -J umcg-${RUNAS}@lobby.hpc.rug.nl molgenis@molgenis${serverId}.gcc.rug.nl '>> \"${PUBLIC_KEY}\" ~/.ssh/authorized_keys'"
    ssh -J umcg-${RUNAS}@lobby.hpc.rug.nl molgenis@molgenis${serverId}.gcc.rug.nl '>> ${TARGET_USER} ~/.ssh/authorized_keys'
    ssh -J umcg-${RUNAS}@lobby.hpc.rug.nl molgenis@molgenis${serverId}.gcc.rug.nl '>> \"${PUBLIC_KEY}\" ~/.ssh/authorized_keys'
done