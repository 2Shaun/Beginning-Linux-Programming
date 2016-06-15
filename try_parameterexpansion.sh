#!/bin/bash

TEMP1="hello"
TEMP2="world"

echo $TEMP2

for i in 1 2
do
	echo ${!TEMP${i}}
done
