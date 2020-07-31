#!/bin/bash

DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

cd ${DIR}/../configs/encrypted

OPTIONS=${1:-"*"}

for FILE in ${OPTIONS}.yaml.gpg; do
    OUTPUT_NAME=$(echo "${FILE}" | rev | cut -f 2- -d '.' | rev)
    echo "Decrypting file: configs/encrypted/${FILE} -> configs/${OUTPUT_NAME}"
    OUTPUT=$(gpg -o ../${OUTPUT_NAME} --decrypt --yes ${FILE} 2>&1> /dev/null )
    STATUS=$?
    if [[ "${STATUS}" != "0" ]]; then
        echo "----"
        echo "!!! Failed !!!"
        echo "${OUTPUT}"
        exit
    fi
done

