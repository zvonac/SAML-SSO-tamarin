#!/bin/bash

set -e 

./scripts/gen_all.sh
./scripts/prove_executables.sh
./scripts/prove_helpers.sh
./scripts/prove_sp_idp_properties.sh
./scripts/prove_client_sp_properties.sh
