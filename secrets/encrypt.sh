#!/bin/bash

DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

cd ${DIR}/../configs

OPTIONS=${1:-"*"}

RECIPIENTS=""
for KEY in $(cat ../secrets/authorized_keys | awk '{print $1}'); do
    RECIPIENTS="${RECIPIENTS} -r ${KEY}"
done

for FILE in ${OPTIONS}.yaml; do
    echo "Encrypting file: configs/${FILE} -> configs/encrypted/${FILE}.gpg"
    OUTPUT=$(gpg --batch --yes -o encrypted/${FILE}.gpg ${RECIPIENTS} -e ${FILE} 2>&1> /dev/null )
    STATUS=$?
    if [[ "${STATUS}" != "0" ]]; then
        echo "----"
        echo "!!! Failed !!!"
        echo "${OUTPUT}"
        exit
    fi
done

