#!/bin/sh

while [ "$1" != "" ]; do
	echo "$1"
	# shifts 1st parameter until we reach the last
	shift
done

exit 0
