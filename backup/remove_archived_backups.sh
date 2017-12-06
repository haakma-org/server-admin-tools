#!/bin/bash

BASE_DIR=/home/backup/old
NUMBER_OF_FILES_TO_REMOVE=20

echo "***************************************************************"
echo "* Remove archived backups                                     *"
echo "***************************************************************"
cd ${BASE_DIR}
NUMBER_OF_FILES=`ls -tr | head -n ${NUMBER_OF_FILES_TO_REMOVE} | wc -l`
if [[ ${NUMBER_OF_FILES} < ${NUMBER_OF_FILES_TO_REMOVE} ]]; then
  echo "No more files to remove"
else
  FILES_TO_REMOVE=`ls -tr | head -n ${NUMBER_OF_FILES_TO_REMOVE}`
  echo ${FILES_TO_REMOVE}
  ls -tr | head -n ${NUMBER_OF_FILES_TO_REMOVE} | xargs rm
fi

echo "***************************************************************"
