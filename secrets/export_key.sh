#!/bin/bash

DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

cd ${DIR}

echo "Exporting key 'secrets/public_keys/my_key.asc'"
gpg --armor --export *@worddive.com > public_keys/my_key.asc

echo "Remember to rename the 'secrets/public_keys/my_key.asc' with your name before commiting!"