set -e
HASKELL_MEMORY=30G
DOCKER_MEMORY=31G
time docker run -it -v ${PWD}:/src -w /src --memory=${DOCKER_MEMORY} tamarin-arch \
	tamarin-prover \
		+RTS -M${HASKELL_MEMORY} -RTS \
		--quit-on-warning \
		$* \
