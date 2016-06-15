#!/bin/bash

vim - -s $1 <<HERE
G
o
- Tommy
:wq
HERE

exit 0
