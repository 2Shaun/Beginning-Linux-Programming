#!/bin/bash
# Very simple example shell script for managing a CD collection.
# Copyright (C) 1996-2007 Wiley Publishing Inc.
# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation; either version 2 of the License, or (at your
# option) any later version.
# This program is distributed in the hopes that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
# Public License for more details.
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.
# 675 Mass Ave, Cambridge, MA 02139, USA.

# global variables
menu_choice=""
current_cd=""
# cdb = content database
title_file="title.cdb"
tracks_file="tracks.cdb"
# $$ = pid
temp_file=/tmp/cdb.$$
# catching the error and removing the temp file
trap 'rm -f $temp_file' EXIT

get_return() {
	# -e enables interpretation of backslash escapes
	# \c is then recognized as 'produce no further input'
	echo -e "Press return \c"
	# receive input from user and set to x
	read x
	return 0
}

get_confirm() {
	echo -e "Are you sure? \c"
	while true
	do
		read x
		case "$x" in
			y | yes | Y | Yes | YES ) 
				# ;; indicated the end of an alternative
				return 0;;
			n | no  | N | No  | NO ) 
				# new line
				echo 
				echo "Cancelled"
				# exits the function
				return 1;;
			# default case
			*) echo "Please enter yes or no" ;;
		esac
	done
}

set_menu_choice() {
	clear
	echo $quit
	echo "Options :-"
	echo
	echo "   a) Add new CD"
	echo "   f) Find CD"
	echo "   c) Count the CDs and tracks in the catalog"
	# cdcatnum is extracted from the
	if [ "$cdcatnum" != "" ]; then
		echo "   l) List tracks on $cdtitle"
		echo "   r) Remove $cdtitle"
		echo "   u) Update track information for $cdtitle"
	fi
	echo "   q) Quit"
	echo
	echo -e "Enter menu choice \c"
	read menu_choice
	return
}

insert_title() {
	# puts all the sent parameters to the function
	# seperated by white space
	# (the first IFS variable)
	# into the title_file (title.cdb)
	echo $* >> $title_file
	return
}

insert_track() {
	echo $* >> $tracks_file
	return
}

add_record_tracks() {
	echo "Enter track information for this CD"
	echo "When no more tracks enter q"
	cdtrack=1
	cdttitle=""
	# assures that we can read the track title
	# and still q when the user enters q
	while [ "$cdttitle" != "q" ]
	do
		# asks the user to input the title for that particular
		# track number
		echo -e "Track $cdtrack, track title? \c"
		# reads it to a temporary variable
		read tmp
		# removes commas from tmp var then sets title
		# commas are one of our field seperators
		cdttitle=${tmp%%,*}
		# if any commas were removed from user input
		if [ "$tmp" != "$cdttitle" ]; then
			echo "Sorry, no commas allowed"
			# continue to the next iteration
			# without incrementing track number
			# allowing the user to try again without commas
			continue
		fi
		# -n refers to NOT NULL
		# so if a track title was chosen
		if [ -n "$cdttitle" ] ; then
			# AND it was not q
			if [ "$cdttitle" != "q" ]; then
				# echo the catnum, track #, and title
				# to the database
				insert_track $cdcatnum,$cdtrack,$cdttitle
			fi
		else
			# if no track title was chosen
			# decrement the track number
			cdtrack=$((cdtrack-1))
		fi
	# increment
	cdtrack=$((cdtrack+1))
	done
}

add_records() {
	# Prompt for the initial information
	echo -e "Enter catalog name \c"
	read tmp
	cdcatnum=${tmp%%,*}
	echo -e "Enter title \c"
	read tmp
	cdtitle=${tmp%%,*}
	echo -e "Enter type \c"
	read tmp
	cdtype=${tmp%%,*}
	echo -e "Enter artist/composer \c"
	read tmp
	cdac=${tmp%%,*}
	# Check that they want to enter the information
	echo About to add new entry
	echo "$cdcatnum $cdtitle $cdtype $cdac"
	# If confirmed then append it to the titles file
	if get_confirm ; then
		# echoes parameters to db	
		insert_title $cdcatnum,$cdtitle,$cdtype,$cdac
		# gets track details from user
		add_record_tracks
	else
		remove_records
	fi 
	return
}

find_cd() {
	# $1 being the first parameter of the function
	if [ "$1" = "n" ]; then
		asklist=n
	else
		# lists tracks 
		asklist=y
	fi
	cdcatnum=""
	echo -e "Enter a string to search for in the CD titles \c"
	read searchstr
	if [ "$searchstr" = "" ]; then
		return 0
	fi
	# uses grep to search the title db
	# then output the lines to a temp file
	grep "$searchstr" $title_file > $temp_file
	# this is so that wc can give us the number of occurences
	set $(wc -l $temp_file)
	linesfound=$l
	case "$linesfound" in
		# if there were 0 occurences
		0)    echo "Sorry, nothing found"
			# Press Enter
			get_return
			return 0
			;;
		1)    ;;
		# if there were more than one occurence of the CD title
		# it will cat them to the screen
		2)    echo "Sorry, not unique."
		echo "Found the following"
		cat $temp_file
		get_return
		return 0
	esac
	IFS=","
	# we can now read comma deliminated fields
	read cdcatnum cdtitle cdtype cdac < $temp_file
	IFS=" "
	# -z is true if empty string
	# so if there is no cdcatnum in the file
	if [ -z "$cdcatnum" ]; then
		echo "Sorry, could not extract catalog field from $temp_file"
		get_return 
		return 0
	fi
	echo
	# Shows details of found CD
	echo Catalog number: $cdcatnum
	echo Title: $cdtitle
	echo Type: $cdtype
	echo Artist/Composer: $cdac
	echo
	get_return
	if [ "$asklist" = "y" ]; then
		echo -e "View tracks for this CD? \c"
		read x
		if [ "$x" = "y" ]; then
			echo
			list_tracks
			echo
		fi
	fi
	return 1
}

update_cd() {
	# if the user didn't enter a catalog number
	if [ -z "$cdcatnum" ]; then
		echo "You must select a CD first"
		# only place where find_cd is called
		find_cd n
	fi
	# if the user did enter a number
	if [ -n "$cdcatnum" ]; then
		echo "Current tracks are :-"
		list_tracks
		echo
		echo "This will re-enter the tracks for $cdtitle"
		# Are you sure?
		get_confirm && {
			# inverted search in the tracks db for
			# a line which begins with (^ notation)
			# the catalog number followed by a comma
			# variable $cdcatnum, is not what we want
			# so we enclose it in {}
			grep -v "^${cdcatnum}," $tracks_file > $temp_file
			# edits the tracks db
			mv $temp_file $tracks_file
			echo
			add_record_tracks
		}
	fi
	return
}

count_cds() {
	set $(wc -l $title_file)
	num_titles=$l
	set $(wc -l $tracks_file)
	num_tracks=$l
	echo found $num_titles CDs, with a total of $num_tracks tracks
	get_return
	return
}

remove_records() {
	if [ -z "$cdcatnum" ]; then
		echo You must select a CD first
		find_cd n
	fi
	if [ -n "$cdcatnum" ]; then
		echo "You are about to delete $cdtitle"
		get_confirm && {
			# you can't grep and output to title_file
			# because as soon as you open a file for output
			# it is emptied
			grep -v "^${cdcatnum}," $title_file > $temp_file
			mv $temp_file $title_file
			grep -v "^${cdcatnum}," $tracks_file > $temp_file
			mv $temp_file $tracks_file
			# resets the user's chosen catalog number
			cdcatnum=""
			echo Entry removed
		}
		get_return
	fi
	return
}

list_tracks() {
	if [ "$cdcatnum" = "" ]; then
		echo no CD selected yet
		return
	else
		# grep from the begining for the cat# we chose
		# output all the lines with that cat# to a temp_file
		grep "^${cdcatnum}," $tracks_file > $temp_file
		# count number of lines in the new temp_file
		num_tracks=$(wc -l $temp_file)
		if [ "$num_tracks" = "0" ]; then
			echo no tracks found for $cdtitle
		else { 
			echo
			echo "$cdtitle :-"
			echo 
			# with -f 2- selected, the first field is cut (cat#)
			# everything from the 2nd field (delimited with ,)
			# is preserved from temp file
			# so it outputs like so: Track#,Title
			cut -f 2- -d , $temp_file 
			echo 
		# many users set their default pager to vim
		# or less, this line honors that
		} | ${PAGER:-more}
		fi
	fi
	get_return
	return
}

rm -f $temp_file
if [ ! -f $title_file ]; then
	touch $title_file
fi
if [ ! -f $tracks_file ]; then
	touch $tracks_file
fi
# Now the application proper
clear
echo
echo
# title screen
echo "Mini CD manager"
sleep 1
quit=n
while [ "$quit" != "y" ];
do
	set_menu_choice
	case "$menu_choice" in
		a ) add_records;;
		r ) remove_records;;
		f ) find_cd y;;
		u ) update_cd;;
		c ) count_cds;;
		l ) list_tracks;;
		b ) 
			echo
			more $title_file
			echo
			get_return;;
		q | Q ) quit=y;;
		* ) echo "Sorry, choice not recognized";;
	esac
done
#Tidy up and leave
rm -f $temp_file
echo "Finished"
exit 0
