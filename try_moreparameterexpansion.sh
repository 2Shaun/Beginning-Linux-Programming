#!/bin/bash
# SUBSTRING EXPANSION
# ${parameter:offset:length}

# from 7 to h will be echoed
string=01234567890abcdefgh
echo ${string:7}

# nothing will be echoed
echo ${string:7:0}

# from 7 to 8 will be echoed
echo ${string:7:2}

# negative numbers are interpreted from the last char
# so from 7 to f will be echoed (g & h) being the two
echo ${string:7:-2}

# from b to h will be echoed
echo ${string: -7}

# nothing will be echoed
echo ${string: -7:0}

# from b to f will be echoed
echo ${string: -7:-2}

echo TESTING PARAMETER EXPANSION

# unsets parameters and 
set -- 01234567890abcdefgh


echo ${1:7}

echo ${1:7:0}

echo ${1:7:2}

echo ${1:7:-2}

echo ${1: -7}

echo ${1: -7:0}
echo ${1: -7:2}

echo ${1: -7:-2}

array[0]=01234567890abcdefgh
echo ${array[0]:7}

echo ${array[0]:7:0}

echo ${array[0]:7:2}

echo ${array[0]:7:-2}

echo ${array[0]: -7}

echo ${array[0]: -7:0}

echo ${array[0]: -7:2}

echo ${array[0]: -7:-2}


