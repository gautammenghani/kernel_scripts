#!/usr/bin/env bash
find . -name "*.c" -o -name "*.py" -o -name "*.h" -o -name "*.sh" > cscope.files
cscope -q -R -b -i cscope.files
