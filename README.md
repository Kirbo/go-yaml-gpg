# Go Yaml GPG

The beaf of this repository is to demonstrate how to encrypt and decrypt YAML files using GPG and how to store environmental variables in YAML files, which can be easily loaded into the `main.go`.


## Prequisites

Install the GPG Suite with Brew:
```sh
brew cask install gpg-suite
```


## Steps to add yourself into authorized keys

1. Clone this repo
2. Run `./secrets/generate_key.sh`
    - Answer the questions the script asks
3. Commit & Push changes
4. Ask someone who is listed in the `./secrets/authorized_keys` to:
    1. Pull the changes
    2. Run `./secrets/import_keys.sh`
    3. Run `./secrets/encrypt.sh`
    4. Commit & Push changes
5. You'll need to Pull the changes
6. Run `./secrets/decrypt.sh`
7. Now you _should_ have decoded config files, e.g.: `./configs/dev.yaml`


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

## Helpful commands:

### Generating GPG key

```sh
./secrets/generate_key.sh
```

### Import the Public keys

```sh
./secrets/import_keys.sh
```

### Export your Public key

```sh
./secrets/export_key.sh
```


### Encrypt / Decrypt secrets

The YAML config files can be decrypted with command:
```sh
# To decrypt all the configs
./secrects/decrypt.sh

# To decrypt only the `dev` environment YAML
./secrects/decrypt.sh dev
```
..and encrypted with:
```sh
# To encrypt all the `./configs/*.yaml` files
./secrects/encrypt.sh

# To encrypt only the `tst` environment YAML
./secrects/encrypt.sh tst
```