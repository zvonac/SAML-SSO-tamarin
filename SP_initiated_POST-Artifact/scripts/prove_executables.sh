#!/bin/bash

set -e 

prove_executables () {
    ./tools/tamarin_batch.sh \
        --heuristic=O \
        --oraclename=SAML.oracle \
        --defines=INCLUDE_EXECUTABLE \
        --defines=INCLUDE_HELPERS \
        --defines=ONE_AGENT_PER_TYPE \
        --defines=ONE_SESSION_PER_AGENT \
        --stop-on-trace=SEQDFS \
        --prove=executable* \
        $*  
}

FILES=SAML_*signed*.spthy

echo "Proving executable lemmas..."

for f in $FILES
do
  echo "Analyzing $f"
  variant=$(basename $f .spthy)
  f_output="analyzed/${variant}_executables_analyzed.spthy"
  f_summary="analyzed/${variant}_executables_summary.txt"
  prove_executables $f --output=$f_output | grep "summary of summaries:" -B 1 -A 1000 > $f_summary
done
