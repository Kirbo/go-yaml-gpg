#!/bin/bash

DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

cd ${DIR}/public_keys

OPTIONS=${1:-"*"}

echo "Importing keys"
for FILE in ${OPTIONS}.asc; do
    OUTPUT_NAME=$(echo "${FILE}" | rev | cut -f 2- -d '.' | rev)
    gpg --yes --import "${FILE}"
done

echo "Adding trust to keys"
for fpr in $(gpg --list-keys --with-colons  | awk -F: '/fpr:/ {print $10}' | sort -u); do echo -e "5\ny\n" | gpg --command-fd 0 --expert --edit-key $fpr trust; done 
