IMAGE_NAME=quay.io/theforeman/candlepin
IMAGE_TAG=4.4.14

build:
	podman build -f images/candlepin/Containerfile -t ${IMAGE_NAME}:${IMAGE_TAG} .

push:
	podman push ${IMAGE_NAME}:${IMAGE_TAG}
