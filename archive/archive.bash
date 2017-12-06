#!/bin/bash

BASE_DIR=`pwd`
NUMBER_OF_YEARS=1

function help() {
  echo "*************************************************************************"
  echo "* Usage                                                                 *"
  echo "*************************************************************************"
  echo "* RUN AS ROOT USER                                                      *"
  echo "* Please specify a timeframe in years                                   *"
  echo "* You can do this with:                                                 *"
  echo "* + -y = [number of years]                                              *"
  echo "* Enter the root-directory you want to run this script from             *"
  echo "* + -d = [directory]                                                    *"
  echo "* For example: ./archive.bash -y 2 -d /'                                *"
  echo "* When all files are older in 1 subdirectory the subdirecty is archived *"
  echo "*************************************************************************"
}

if [ $# -eq 0 ]; then
    help
    exit 1
fi

while getopts :hy:d: opt; do
    case ${opt} in
        h) help; exit
        ;;
        y) NUMBER_OF_YEARS=${OPTARG}
        ;;
        d) BASE_DIR=${OPTARG}
        ;;
        :) echo "Missing argument for option -${OPTARG}"; exit 1
        ;;
       \?) echo "Unknown option -${OPTARG}"; exit 1
        ;;
    esac
done

PERIOD=$((${NUMBER_OF_YEARS}*365))

echo ""
echo "######################################################################"
echo "# Script is running for all files older then: [ ${NUMBER_OF_YEARS} ] #"
echo "# Script root-directoryi:                     [ ${BASE_DIR} ]        #"
echo "######################################################################"
DIR_LIST=$(find ${BASE_DIR/} -iname "*" -mtime +${PERIOD} | cut -d/ -f -3 | sort -u)
for ((index = 0; index < ${#DIR_LIST[@]}; ++index)); do
 if [ ${index} = 0 ]; then
  echo "root directory is: ${DIR_LIST[index]}"
 else
  echo "${DIR_LIST[index]}"
 fi
done
