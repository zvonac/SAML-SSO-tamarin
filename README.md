# SAML V2.0 Web Browser SSO Tamarin models

## Description
This archive contains symbolic models of **SAML V2.0 Web Browser SSO Profile** and comprehensive set of security properties agianst which models can be verified using Tamarin prover.
The [Tamarin prover](https://tamarin-prover.github.io/) is tool for symbolic modeling and automated analysis of security protocols.

Currently this archive contains Tamarin sympbolic models for 8 variants of ***SP-initiated SSO with POST/Artifact Bindings*** use case.


## Size
Total size of archive is 2,1MB compressed and 90MB decompressed.

## Platform and Environment
Suplementary code and scripts used for initiating automatic verification using Tamarin Prover and other accompanying actions are intended for use on the Linux operating system.
Docker installation is required, as the automatic verification process is initiated using Docker containers.

## Major Component Description
**SP-initiated SSO with POST/Artifact Bindings** use case is modeled using Tamarin langugage in *meta symbolic model* `SAML_meta.spthy`  which is then translated into 8 symbolic models using `gpp` with different flags.
All 8 models can be generated using script:
```
./scpripts/gen_all.sh
```
Every symbolic model represents one variant of **SP-initiated SSO with POST/Artifact Bindings*** use case discribed in paper.

`SP_initiated_POST-Artifact\analyzed` dirctory contains a pair of result files for every variant and for every set of properties (helpers, executables, Client-SP and SP-IdP):
- `*_analyzed.spthy` - Tamarin file containing all verification steps.
- `*_summary.txt` - text summary file showing which properties have been verified or falsifed.
`SP_initiated_POST-Artifact\scripts` - contains scripts used for model generating, automatic verification execution and parsing verification resutls.
`SP_initiated_POST-Artifact\tools` - contains scripts used for building Docker image, and executing tamarin docker image in interactive or batch mode. 


## Detailed Set-up and Run Instructions
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

Before starting tamarin using scripts or tools, depending on your system memory you should adjust HASKELL_MEMORY and DOCKER_MEMORY parameters in tools files.
Wiht more memory and CPU, verification will pass quicker, using 16 CPUs and 20 GB RAM for Docker, we managed to verify all propreties for all variants in 10 hours.

To explore models and execute verification manualy through graphical interface use (once the server starts connect with browser to `http://localhost:3001`):
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
To generate and prove all properties automaticaly run:
```
./scripts/gen_and_prove_all.sh
```
To parse results into overview table run:
```
./scripts/parse_results.py
```

## Output Description
Formal verification through `scripts/prove_*` generates two result files in directory `analyzed`:
- `*_analyzed.spthy`
- `*_summary.txt`
First one is Tamarin file that contains all verification steps, and other is text summary files which shows which properties have been verified or falsifed.
Using `scprits/parse_results.py` all `*_summary.txt` files are parsed and script generetes single `summary.txt` file that contains an overview table showing which scurity properties were verified (marked with 'o') and which are falsifed (marked with 'x') for every use-case variant. Executable and helper lemmas are just briefly mentioned in `summary.txt`.

## Contact Information
Corresponding author: Zvonimir Hartl (zvonimir.hartl@fer.hr).
