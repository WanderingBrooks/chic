#!/bin/bash

desktop=sublime_text.desktop
applications=~/.local/share/applications
cd $applications
ls
if [ -e $desktop ]
then
	echo "$desktop exists"
	 
fi

exit
