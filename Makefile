IMAGE_NAME=quay.io/foreman/candlepin

PROJECT_XY_TAG=5.0
PROJECT_XYZ_TAG=5.0.3

FOREMAN_XY_TAG=foreman-5.0
FOREMAN_XYZ_TAG=foreman-5.0.1

IMAGE_TAGS=${IMAGE_NAME}:${PROJECT_XY_TAG} ${IMAGE_NAME}:${PROJECT_XYZ_TAG} ${IMAGE_NAME}:${FOREMAN_XY_TAG} ${IMAGE_NAME}:${FOREMAN_XYZ_TAG}

build:
	cd images/candlepin && podman build --file Containerfile --build-arg VERSION=${PROJECT_XY_TAG} --build-arg VERSION_XYZ=${PROJECT_XYZ_TAG} --tag ${IMAGE_NAME}:${PROJECT_XYZ_TAG}	.
	$(foreach tag,$(IMAGE_TAGS),\
		podman tag ${IMAGE_NAME}:${PROJECT_XYZ_TAG} $(tag); \
	)

push:
	$(foreach tag,$(IMAGE_TAGS),\
		podman push $(tag);\
	)

# RPM lockfile maintenance (foreman-5.0 hermetic inputs)
RPM_LOCKFILE_VERSION ?= v0.30.1
RPM_LOCKFILE_IMAGE ?= localhost/rpm-lockfile-prototype:$(RPM_LOCKFILE_VERSION)
RPM_LOCKFILE_CONTAINERFILE_URL ?= https://raw.githubusercontent.com/konflux-ci/rpm-lockfile-prototype/refs/heads/main/Containerfile

.PHONY: refresh-rpm-lockfiles refresh-rpm-lockfile rpm-lockfile-prototype-image
refresh-rpm-lockfiles: refresh-rpm-lockfile

refresh-rpm-lockfile: rpm-lockfile-prototype-image
	podman run --rm --volume "$(CURDIR):/work:z" \
		--workdir /work/images/candlepin \
		$(RPM_LOCKFILE_IMAGE) --outfile=rpms.lock.yaml rpms.in.yaml

rpm-lockfile-prototype-image:
	@if ! podman image exists "$(RPM_LOCKFILE_IMAGE)"; then \
		curl --fail --location "$(RPM_LOCKFILE_CONTAINERFILE_URL)" | \
			podman build --build-arg GIT_REF=tags/$(RPM_LOCKFILE_VERSION) \
				--tag "$(RPM_LOCKFILE_IMAGE)" -; \
	fi
