# Go Yaml GPG

The beaf of this repository is to demonstrate how encrypt and decrypt YAML files using GPG and how to store environmental variables in YAML files, which can be easily loaded into the `main.go`.

## Encrypt / Decrypt secrets
The YAML config files can be decrypted with command:
```
./secrects/decrypt.sh
```
..and encrypted with:
```
./secrects/encrypt.sh
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
Loading different environment configurations on start-up, use either:
```
ENV=tst go run main.go
```
or:
```
go run main.go --env=tst
```

By default `configs/dev.yaml` configurations are loaded.
