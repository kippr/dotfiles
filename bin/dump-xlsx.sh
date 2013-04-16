#!/bin/bash
#set -e
TMPFILE=`mktemp -d -t dump-xlsx`
ssconvert  -S -T Gnumeric_stf:stf_csv "$1" "$TMPFILE/out" 2>/dev/null
cat $TMPFILE/out*
rm -rf $TMPFILE
