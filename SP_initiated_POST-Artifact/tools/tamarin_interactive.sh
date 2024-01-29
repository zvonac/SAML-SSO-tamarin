set -e
HASKELL_MEMORY=30G
DOCKER_MEMORY=31G
docker run -it -v ${PWD}:/src -w /src --memory=${DOCKER_MEMORY} -p 3001:3001 tamarin-arch \
	tamarin-prover \
		+RTS -M${HASKELL_MEMORY} -RTS \
		interactive \
		--quit-on-warning \
		--interface=*4  \
		--image-format=svg \
		$* \
		.