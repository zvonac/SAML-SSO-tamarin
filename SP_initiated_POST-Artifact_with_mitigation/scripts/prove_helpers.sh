#!/bin/bash

set -e 

prove_helper_properties () {
    ./tools/tamarin_batch.sh \
        --heuristic=O \
        --oraclename=SAML.oracle \
        --defines=INCLUDE_HELPERS \
        --prove=helper* \
        --prove=https_typing* \
        $* 
}

FILES=SAML_*signed*.spthy

echo "Proving helper lemmas..."

for f in $FILES
do
  echo "Analyzing $f"
  variant=$(basename $f .spthy)
  f_output="analyzed/${variant}_helpers_analyzed.spthy"
  f_summary="analyzed/${variant}_helpers_summary.txt"
  prove_helper_properties $f --output=$f_output | grep "summary of summaries:" -B 1 -A 1000 > $f_summary
done
