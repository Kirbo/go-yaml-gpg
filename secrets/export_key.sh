#!/bin/bash

DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

cd ${DIR}

read -p "Please provide your fullname, e.g.: Firstname Lastname: " FULLNAME
read -n 1 -p "Is this name correct: '${FULLNAME}'? [ y / N ]: " ANSWER

case $ANSWER in
    [Yy]* ) echo;;
    * ) echo "Please start over"; exit;;
esac

UNDERSCORED=$(echo "${FULLNAME}" | sed -e 's/ /_/g')
LOWECASE=$(echo "${UNDERSCORED}" | tr '[:upper:]' '[:lower:]')
EMAIL="${LOWERCASE}@worddive.com"

KEYID=$(gpg --list-keys --with-colons ${EMAIL} | awk -F: '/^pub:/ { print $5 }')

FILENAME="${UNDERSCORED}_(${KEYID}).asc"

echo "Exporting key 'secrets/public_keys/${FILENAME}'"
gpg --armor --export ${EMAIL} > public_keys/${FILENAME}

echo "Adding into 'secrets/authorized_keys'"
echo "${KEYID}    # ${FULLNAME}" >> authorized_keys