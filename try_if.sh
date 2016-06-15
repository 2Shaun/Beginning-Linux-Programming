#!/bin/bash

echo "Is it morning? Please answer yes or no"
read timeofday

# without quotes around the variable
# \n would get expanded to [ = "yes" ]
# which causes a syntax error
if [ "$timeofday" = "yes" ]; then
	echo "Good morning"
elif [ "$timeodday" = "no" ]; then
	echo "Good afternoon"
else 
	echo "Sorry, $timeofday not recognized. Enter yes or no"
	exit 1
fi

exit 0
