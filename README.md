# docker-compose-deploy

## Environment Variables

### Docker Machine Cert Bundle
Convert a docker-machine cert bundle for sharing by taring and base64 encoding the `ca.pem`, `cert.pem`, and `key.pem` files like the following:

`DOCKER_MACHINE_CERT=`

```
tar -c ca.pem cert.pem key.pem | gzip | base64 | pbcopy
```

### Docker Compose

Docker compose can combine mulptiple docker-compose.*.yml and env files into a single `docker-compose.yml` output using `docker-compose config` but it kinda messes things up when doing it. The following command uses some `sed`s to correct the small problems docker compose creates for itself.

So instead of needing fancy `docker-compose -f ... -f ... up` only a `docker-compose up` can be used.

In the following example replace -f ... with the series of -f options that would be used for docker-compose to interact with a particular environment and configuration.

`DOCKER_COMPOSE=`

```
docker-compose -f ... config | sed "s|:rw\$||" | sed "s|\\$|\$\$|" | gzip | base64 | pbcopy
```

### Docker Hub Credentials

If using private repositories on Dockerhub the credentials will be needed.

`DOCKER_CREDENTIAL=`

```
cat dockercfg | gzip | base64 | pbcopy
```

## Codeship Usage:

Mac Instructions for encrypting the above base64 encoded environment variables for secure use in `codeship-services.yml` or `codeship-steps.yml`:

Append an encoded environment variable value to the environment variable name with` =`. For instance `DOCKER_MACHINE_CERT=BASE64_ENCODED_VALUE_SEE_INSTRUCTIONS_ABOVE`. Copy the whole key value pair as a string and use the following to encrypt it.

```
pbpaste > raw.tmp && jet encrypt raw.tmp crypt.tmp && cat crypt.tmp | pbcopy && rm raw.tmp crypt.tmp
```

The value can now be added an array item to a `encrypted_environment` in `codeship-services.yml` or `codeship-steps.yml`.
