set -e
HASKELL_MEMORY=22G
DOCKER_MEMORY=24G
time docker run -it -v ${PWD}:/src -w /src --memory=${DOCKER_MEMORY} tamarin-arch \
	tamarin-prover \
		+RTS -M${HASKELL_MEMORY} -RTS \
		--quit-on-warning \
		$* \
	| sed -E -e 's/(analysis incomplete)/\x1b[94m\1\x1b[0m/g' -e 's/(verified)/\x1b[32m\1\x1b[0m/g' -e 's/(falsified)/\x1b[91m\1\x1b[0m/g'
