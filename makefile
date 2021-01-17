# ############################################################################
# Ubuntu 20.04 (Focal Fossa) Desktop minimal install — Makefile
#
#	Description
#	###########
#
#	A helper makefile to aid building and running the Ubuntu 20.04 Desktop 
#	minimal install image.
#
# ############################################################################

# Global vars ################################################################

DOCKERFILE=Dockerfile
TAG=ubuntu:focal_min
USERNAME=
USERID=
OPTS=
CMD=


# Build image ################################################################

# Default user image
image: Dockerfile
	docker image build \
		--file=${DOCKERFILE} \
		--tag=${TAG} \
		--rm \
		--build-arg=USERNAME=${USERNAME} \
		--build-arg=USERID=${USERID} \
		.build

# Remove all images
.PHONY: clean
clean:
	docker image prune -f


# Run image ##################################################################

.PHONY: run
run:
	docker run \
		--rm \
		--interactive \
		--tty \
		${OPTS} ${TAG} ${CMD}

