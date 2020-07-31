# Go Yaml GPG

The beaf of this repository is to demonstrate how encrypt and decrypt YAML files using GPG and how to store environmental variables in YAML files, which can be easily loaded into the `main.go`.

## Encrypt / Decrypt secrets

The YAML config files can be decrypted with command:
```sh
# To decrypt all the configs
./secrects/decrypt.sh

# To decrypt only the `dev` environment YAML
./secrects/decrypt.sh dev
```
..and encrypted with:
```sh
# To encrypt all the ./configs/*.yaml
./secrects/encrypt.sh

# To encrypt only the `tst` environment YAML
./secrects/encrypt.sh tst
```


## Adding authorized public keys

To add access to decrypt the secrets, you need to:
1. Add the KEY ID of the new public key, into the `secrets/authorized_keys` file
2. Encrypt the secrets again, since it will add the previously added key into the recipients
3. Push the changes into the repository

4. The person whos key just got added, should then pull the changes
5. ..and run the `scripts/decrypt.sh` script.

Now you should have decrypted YAML files under the `configs/` path

## Using environmental configs

Loading different environment configurations on start-up, e.g.:
```sh
# Using the Environmental variable
ENV=tst go run main.go

# By passing it as a flag
go run main.go --env=tst
```

By default `configs/dev.yaml` configurations are loaded.

Of course the same applies also if you've built the program, e.g.:
```sh
# Build the program
go build

# Using the Environmental variable
ENV=tst ./goyaml

# By passing it as a flag
./goyaml --env=tst
```