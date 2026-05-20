IMAGE_NAME=quay.io/foreman/candlepin

PROJECT_XY_TAG=4.7
PROJECT_XYZ_TAG=${PROJECT_XY_TAG}.4

FOREMAN_XY_TAG=foreman-3.19
FOREMAN_XYZ_TAG=foreman-3.19

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
