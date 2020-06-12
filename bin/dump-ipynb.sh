#!/bin/bash
#set -e
jq --indent 1 \
    '
    (.cells[] | select(has("execution_count")) | .execution_count) = null
    | (.cells[] | select(has("metadata")) | .metadata) = {}
    | .metadata = {"language_info": {"name":"python", "pygments_lexer": "ipython3"}}
    | (.cells[] | select(has("outputs")) | .outputs[0]["data"]["text/html"]) = []
    | (.cells[] | select(has("outputs")) | .outputs[0]["execution_count"]) = null
    ' "$1"
