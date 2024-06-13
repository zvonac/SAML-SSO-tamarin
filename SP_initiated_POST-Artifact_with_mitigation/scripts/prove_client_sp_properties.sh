#!/bin/bash

set -e 

prove_client_properties () {
    ./tools/tamarin_batch.sh \
        --heuristic=O \
        --oraclename=SAML.oracle \
        --defines=INCLUDE_HELPERS \
        --stop-on-trace=SEQDFS \
        --prove=sec_Client* \
        --prove=sec_SP_Client* \
        $* 
}

FILES=SAML_*signed*.spthy

echo "Proving properties between Client and SP..."

for f in $FILES
do
  echo "Analyzing $f"
  variant=$(basename $f .spthy)
  f_output="analyzed/${variant}_client_sp_analyzed.spthy"
  f_summary="analyzed/${variant}_client_sp_summary.txt"
  prove_client_properties $f --output=$f_output | grep "summary of summaries:" -B 1 -A 1000 > $f_summary
done
