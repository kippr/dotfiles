#!/bin/bash
cat $1 | awk '{ gsub(/\\n/,"\n"); print }' > /tmp/build.txt
