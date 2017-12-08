#!/bin/bash

BASE_DIR=/home/backup/

echo "***************************************************************"
echo "* Cleanup old backups                                         *"
echo "***************************************************************"
FILES_TO_CLEAN=`find ${BASE_DIR}/today -iname "*" -mtime +7`
if [[ -z ${FILES_TO_CLEAN} ]]; then
  echo "No files to cleanup"
else
  echo ${FILES_TO_CLEAN}
  find ${BASE_DIR}/today -iname "*" -mtime +7 | xargs -I '{}' mv {} ${BASE_DIR}/old
fi

echo "***************************************************************"
