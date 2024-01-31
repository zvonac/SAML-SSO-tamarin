set -e
HASKELL_MEMORY=19G
DOCKER_MEMORY=20G
time docker run -it -v ${PWD}:/src -w /src --memory=${DOCKER_MEMORY} tamarin-arch \
	tamarin-prover \
		+RTS -M${HASKELL_MEMORY} -RTS \
		--quit-on-warning \
		$* \
