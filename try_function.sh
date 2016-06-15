#!/bin/bash

sample_text="global variable"

# function must always be defined before executing
foo() {
	local sample_text="local variable"
	echo "Function foo is executing"
	echo $sample_text
}

echo "script starting"
foo
echo "scipt ended"

exit 0
