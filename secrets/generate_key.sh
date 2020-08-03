#!/bin/bash

DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

cd ${DIR}

rm gen-key-script

read -p "Please provide your fullname, e.g.: Firstname Lastname: " FULLNAME
read -n 1 -p "Is this name correct: '${FULLNAME}'? [ y / N ]: " ANSWER
case $ANSWER in
    [Yy]* ) echo;;
    * ) echo "Please start over"; exit;;
esac

UNDERSCORED=$(echo "${FULLNAME}" | sed -e 's/ /_/g')
DOTNOTATION=$(echo "${FULLNAME}" | sed -e 's/ /./g')
LOWERCASE_UNDERSCORE=$(echo "${UNDERSCORED}" | tr '[:upper:]' '[:lower:]')
LOWERCASE_DOTNOTATION=$(echo "${DOTNOTATION}" | tr '[:upper:]' '[:lower:]')
EMAIL="${LOWERCASE_DOTNOTATION}@worddive.com"

read -n 1 -p "Is this email address correct: '${EMAIL}'? [ y / N ]: " ANSWER

case $ANSWER in
    [Yy]* ) echo;;
    * ) echo "Please start over"; exit;;
esac

echo "Generating GPG key for: ${FULLNAME} (${EMAIL})"
echo "%no-protection
Key-Type: 1
Key-Length: 2048
Subkey-Type: 1
Subkey-Length: 2048
Expire-Date: 0
Name-Real: ${FULLNAME}
Name-Email: ${EMAIL}" > gen-key-script
gpg --batch --gen-key gen-key-script
rm gen-key-script

KEYID=$(gpg --list-keys --with-colons ${EMAIL} | awk -F: '/^pub:/ { print $5 }')

FILENAME="${UNDERSCORED}_(${KEYID}).asc"

echo "Exporting key 'secrets/public_keys/${FILENAME}'"
gpg --armor --export ${EMAIL} > public_keys/${FILENAME}

echo "Adding into 'secrets/authorized_keys'"
echo "${KEYID}    # ${FULLNAME}" >> authorized_keys