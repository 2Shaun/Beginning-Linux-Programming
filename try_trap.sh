#!/bin/sh

# trap will issue the command in single-quotes
# when an INT (interrupt) signal occurs
# so the file exists until the user presses CTRL-C
trap 'rm -f /tmp/my_tmp_file_$$' INT
# $$ is the pid
echo creating file /tmp/my_tmp_file_$$
date > /tmp/my_tmp_file_$$

echo "press interrupt (CTRL-C) to interrupt ...."
while [ -f /tmp/my_tmp_file_$$ ]; do
	echo File exists
	sleep 1
done
echo The file no longer exists

trap INT
echo creating file /tmp/my_tmp_file_$$
date > /tmp/my_tmp_file_$$

echo "press interrupt (CTRL-C)i to interrupt ...."
while [ -f /tmp/my_tmp_file_$$ ]; do
	echo File exists
	sleep 1
done

echo we never get here
exit 0

