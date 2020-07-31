#!/bin/bash

DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

cd ${DIR}/../configs/encrypted

OPTIONS=${1:-"*"}

for FILE in ${OPTIONS}.yaml.gpg; do
    echo "Decrypting file: ${FILE}"
    OUTPUT_NAME=$(echo "${FILE}" | rev | cut -f 2- -d '.' | rev)
    gpg -o ../${OUTPUT_NAME} --decrypt --yes ${FILE}
done

