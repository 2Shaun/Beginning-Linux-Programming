#!/bin/bash

foo="Hello World"
echo $foo

# foo= instead of unset foo would set the value of foo to NULL
# unset foo removes the variable entirely
unset foo
echo $foo

exit 0
