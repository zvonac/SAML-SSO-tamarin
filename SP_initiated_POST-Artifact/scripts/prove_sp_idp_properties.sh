#!/bin/bash

set -e 

prove_sp_idp_properties () {
    ./tools/tamarin_batch.sh \
        --defines=INCLUDE_HELPERS \
        --defines=NO_CLIENTS \
        --stop-on-trace=SEQDFS \
        --heuristic=O \
        --oraclename=SAML.oracle \
        --prove=sec_IdP_SP* \
        --prove=sec_SP_IdP* \
        $* 
}

FILES=SAML_*signed*.spthy

echo "Proving properties between SP and IdP..."

for f in $FILES
do
  echo "Analyzing $f"
  variant=$(basename $f .spthy)
  f_output="analyzed/${variant}_sp_idp_analyzed.spthy"
  f_summary="analyzed/${variant}_sp_idp_summary.txt"
  prove_sp_idp_properties $f --output=$f_output | grep "summary of summaries:" -B 1 -A 1000 > $f_summary
done
