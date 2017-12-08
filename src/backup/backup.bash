#!/bin/bash

BASE_PATH=`pwd`

DATE=`date +%Y-%m-%d`
BASE_DIR=/home/backup/today

CONFIG_DIR=/home/config/vsftpd

echo "***************************************************************"
echo "* Commence backup template                                    *"
echo "***************************************************************"

echo "[INFO] Backup : ${CONFIG_DIR}"
tar -cvf ${BASE_DIR}/${DATE}_backup_name.tar ${CONFIG_DIR}

echo "***************************************************************"





