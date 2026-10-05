IMAGE_NAME=quay.io/foreman/candlepin

PROJECT_XY_TAG=5.0
PROJECT_XYZ_TAG=5.0.3

FOREMAN_XY_TAG=foreman-5.0
FOREMAN_XYZ_TAG=foreman-5.0.1

IMAGE_TAGS=${IMAGE_NAME}:${PROJECT_XY_TAG} ${IMAGE_NAME}:${PROJECT_XYZ_TAG} ${IMAGE_NAME}:${FOREMAN_XY_TAG} ${IMAGE_NAME}:${FOREMAN_XYZ_TAG}

build:
	podman build --file images/candlepin/Containerfile --build-arg VERSION=${PROJECT_XY_TAG} --build-arg VERSION_XYZ=${PROJECT_XYZ_TAG} --tag ${IMAGE_NAME}:${PROJECT_XYZ_TAG}	.
	$(foreach tag,$(IMAGE_TAGS),\
		podman tag ${IMAGE_NAME}:${PROJECT_XYZ_TAG} $(tag); \
	)

push:
	$(foreach tag,$(IMAGE_TAGS),\
		podman push $(tag);\
	)
