#!/bin/bash

# search starting at /
# for a file named test
# print out the name of file
# find / -name test -print
# find [path] [options] [tests] [actions]

# search current directory
# for files which begin with try_
# or
# accessed today
# print their names
# find . \( -name "try_*" -or -atime 0 \) -type f -print

# find all files which start with classical in ~/Pictures/
# then display them
# \; tells when find to stop using the -exec flag
find ~/Pictures/ -name "classical*" -type f -exec display {} \;

exit 0
