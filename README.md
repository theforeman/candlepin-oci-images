# Candlepin Container Images

The [candlepin-oci-images](https://github.com/theforeman/candlepin-oci-images) repository is used to provide a Candlepin container image configured for the Foreman project's use case.
It follows [foremanctl's container builds structure](https://github.com/theforeman/foremanctl/blob/master/docs/developer/container-image-builds.md).

Note that OCI stands for "Open Container Initiative", see [here](https://opencontainers.org/).

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
