# Repository agent notes

This repository builds the Candlepin OCI image for Foreman.

## RPM build modes

- `master` builds the nightly image with ordinary DNF repository resolution; this is
  not a hermetic RPM build.
- `foreman-5.0` uses Hermeto-prefetched RPMs in Konflux. The `.tekton/candlepin-5-0-*`
  pipelines set `hermetic: "true"` and pass `USE_HERMETO_REPOS=true`.
- The RPM inputs and lock are `images/candlepin/rpms.in.yaml` and
  `images/candlepin/rpms.lock.yaml`. The input names the repository files under `repos/`.
- `make build` invokes Podman directly and does not run Hermeto. Do not treat a local
  build as validation of Konflux prefetching.

## Refreshing the RPM lockfile

The target is present on `master` for future versioned branches, but current `master`
has no RPM lock inputs. On `foreman-5.0`, run `make refresh-rpm-lockfiles`. The target
builds the official
`rpm-lockfile-prototype` helper image locally with Podman when needed, defaults to
upstream release `v0.30.1`, and does not publish the helper image. The repository mount
uses `:z` for SELinux relabeling. Keep this target separate from `build` and GHA.

The input has an explicit `packages` list, which takes precedence over Containerfile
package scanning. Update `images/candlepin/rpms.in.yaml` when changing RPM packages, then
refresh and review `images/candlepin/rpms.lock.yaml`.

## Publishing and troubleshooting

Konflux publishes images through the branch push pipelines after merge. Do not present
local Makefile `push` targets as the release workflow. For hermetic failures, inspect the
`prefetch-dependencies` task logs first, then `build-container`; verify the `.tekton`
Candlepin pipeline for the branch.

## References

- [shared hermetic RPM guide](https://github.com/theforeman/theforeman-rel-eng-konflux/blob/develop/docs/hermetic-rpm-builds.md)
- [Konflux dependency prefetching](https://konflux-ci.dev/docs/building/prefetching-dependencies/)
- [Hermeto RPM dependencies](https://hermetoproject.github.io/hermeto/rpm/)
- [rpm-lockfile-prototype container instructions](https://github.com/konflux-ci/rpm-lockfile-prototype#running-in-a-container)
- [rpm-lockfile-prototype package precedence](https://github.com/konflux-ci/rpm-lockfile-prototype#containerfile-package-scanning-and-packages-precedence)
- [MintMaker RPM lockfiles](https://konflux-ci.dev/docs/mintmaker/rpm-lockfile/)
- [MintMaker support](https://konflux-ci.dev/docs/mintmaker/support/)
- [MintMaker user guide](https://konflux-ci.dev/docs/mintmaker/user/)
- [Renovate documentation](https://docs.renovatebot.com/)
- [Foreman OCI images README](https://github.com/theforeman/foreman-oci-images/blob/master/README.md)
- [Pulp OCI images README](https://github.com/theforeman/pulp-oci-images/blob/master/README.md)
- [Candlepin OCI images README](https://github.com/theforeman/candlepin-oci-images/blob/master/README.md)
