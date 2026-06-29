# Candlepin Container Images

The [candlepin-oci-images](https://github.com/theforeman/candlepin-oci-images) repository is used to provide a Candlepin container image configured for the Foreman project's use case.
It follows [foremanctl's container builds structure](https://github.com/theforeman/foremanctl/blob/master/docs/developer/container-image-builds.md).

Note that OCI stands for "Open Container Initiative", see [here](https://opencontainers.org/).

## Environment variables

The container can be configured using environment variables.

| Variable                      | Description                                  |
|-------------------------------|----------------------------------------------|
| `CANDLEPIN_DB_PASSWORD`       | Password to the database                     |
| `CANDLEPIN_DB_URL`            | URL to connect to the database               |
| `CANDLEPIN_DB_USERNAME`       | Username to the database                     |
| `CANDLEPIN_HOSTNAME`          | Hostname to listen on                        |
| `CANDLEPIN_KEYSTORE_PASSWORD` | Password to both the keystore and truststore |
| `CANDLEPIN_OAUTH_SECRET`      | OAuth consumer secret that Katello can use   |
| `CANDLEPIN_PORT`              | Port to listen on                            |
| `CANDLEPIN_TLS_CIPHERS`       | TLS ciphers to use                           |
| `CANDLEPIN_TLS_VERSIONS`      | TLS versions to use                          |

## How to Build

To build the container image locally:

```
make build
```

## How to Release

To push a new version of the container:

```
make push
```
