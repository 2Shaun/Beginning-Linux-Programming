#!/bin/zsh

# first.sh
# This file looks through all the files in the current
# directory for the string POSIX, and then displays those
# files to the standard output

for file in *
do
	if grep -q POSIX $file
	then
		more $file
	fi
done

exit 0
