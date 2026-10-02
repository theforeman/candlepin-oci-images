# Candlepin Container Images

The [candlepin-oci-images](https://github.com/theforeman/candlepin-oci-images) repository is used to provide a Candlepin container image configured for the Foreman project's use case.
It follows [foremanctl's container builds structure](https://github.com/theforeman/foremanctl/blob/master/docs/developer/container-image-builds.md).

Note that OCI stands for "Open Container Initiative", see [here](https://opencontainers.org/).

## How to Build

To build the container image locally:

```
make build
```

The image keeps the normal Tomcat command as its default. Orchestrators that
run schema migration separately can invoke `candlepin-db-migrate` with standard
Liquibase arguments before starting the application. Both commands run as the
numeric UID/GID of the packaged `tomcat` account, so the same image works with
standalone Podman and runtimes that enforce a non-root identity. The migration
wrapper selects the Java 25 runtime required by the packaged Liquibase changes
without changing the Java runtime selected by the normal Tomcat entry point.

## How to Release

To push a new version of the container:

```
make push
```
