#!/bin/bash
set -e
unzip  -cq "$1" word/document.xml | sed 's#</w:p>#\'$'\n#g;s#<[^>]*>##g'
