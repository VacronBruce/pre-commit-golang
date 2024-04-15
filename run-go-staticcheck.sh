#!/usr/bin/env bash

set -eu -o pipefail

if ! command -v staticcheck &> /dev/null ; then
    echo "staticcheck not installed or available in the PATH" >&2
    echo "please check https://staticcheck.io/docs/" >&2
    exit 1
fi

failed=false

for file in "$@"; do
    # redirect stderr so that violations and summaries are properly interleaved.
    if ! staticcheck "$file" 2>&1
    then
        failed=true
    fi
done

if [[ $failed == "true" ]]; then
    exit 1
fi
