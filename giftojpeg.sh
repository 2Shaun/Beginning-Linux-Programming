#!/bin/bash

# all the gifs will now run through this loop 
# with the variable name image
for image in *.gif
do
	# cjpeg will convert the image
	# to a jpeg of the same name except
	# with gif removed (searched for "gif"
	# from the end of the string and removed
	# it), then appended jpeg to it
	cjpeg $image > ${image%%gif}jpeg
done
