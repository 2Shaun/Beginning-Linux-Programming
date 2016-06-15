#!/bin/bash

echo the date is $(date)
# the parameters for this shell are now
# as returned from the date command
set $(date)
echo The day is $1
echo The month is $2
echo The date is $3
echo The time is $4
echo The time zone is $5
echo The year is $6

exit 0
