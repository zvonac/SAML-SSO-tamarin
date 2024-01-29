# SAML V2.0 Web Browser SSO Tamarin models

This project contains symbolic models of **SAML V2.0 Web Browser SSO Profile** and comprehensive set of security properties agianst which models can be verified using Tamarin prover.
The [Tamarin prover](https://tamarin-prover.github.io/) is tool for symbolic modeling and automated analysis of security protocols.

Currently this project contains Tamarin sympbolic models for 8 variants of ***SP-initiated SSO with POST/Artifact Bindings*** use case.

## How is code organized?

SP-initiated SSO with POST/Artifact Bindings use case symbolic model is written as *meta model*.
Using different flags this *meta model* can be turned into 8 different model variants.

## How to run?
> Scripts and tools imply you have Docker installed.

Position to SP-initiated SSO with POST/Artifact Bindings use-case directory.
```
cd SP_initiated_POST-Artifact/
```
Build Docker image with Tamarin 1.6.1 wich will be used for verification.
```
./tools/tamarin_build.sh
```
To generate new models if you modify *meta model* use:
```
./scpripts/gen_all.sh
```
To explore models and proofs interactively use:
```
./tools/tamarin_interactive.sh
```
To prove properties as batch jobs run:
```
./scripts/prove_helpers.sh
./scripts/prove_executables.sh
./scripts/prove_client_sp_properties.sh
./scripts/prove_sp_idp_properties.sh
```
To generate and prove all properties run:
```
./scripts/gen_and_prove_all.sh
```

