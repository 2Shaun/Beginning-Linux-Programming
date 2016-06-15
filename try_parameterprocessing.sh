#!/bin/sh

# assures there's no foo variable
unset foo

# {foo:-bar}
# foo = NULL
#	return bar
# else
#	return foo
# echo foo
echo ${foo:-bar}

# {foo:=bar}
# foo && foo != NULL
# 	return foo
# else
#	foo = bar
#	return foo
#
# now sets foo to fud
echo ${foo:=fud}

# since foo is not NULL
# "fud" will be echoed
echo ${foo:-bar}

# sets foo to the location of startx
foo=/usr/bin/X11/startx

# FROM BEGINING
# removes the smallest part that matches */
# the first / is the smallest substring which does
# therefore it echoes "usr/bin/X11/startx"
echo ${foo#*/}

# ## removes as much as possible, since usr, bin, and X11 all have the same
# amount of characters, they are all removed and "startx" is returned
echo ${foo##*/}

# sets bar to the location of networks
bar=/usr/local/etc/local/networks

# FROM THE END
# removes the smallest part that matches local*
# local/networks is smaller than local/etc/local/networks
# therefore it echoes /usr/local/etc
echo ${bar%local*}
 
# /usr is echoed because /local/etc/local/networks is the largest substring
echo ${bar%%local*}

exit 0
