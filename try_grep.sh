#!/bin/bash

echo lines with \'in\'
grep in words.txt

echo count of lines with \'in\'
grep -c in words.txt 

echo count of lines without \'in\'
grep -c -v in words.txt

echo lines with words that are exactly 10 lower case characters long
grep -E [[:space:]][a-z]\{10\}[[:space:]] words2.txt

exit 0
