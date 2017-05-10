#!/bin/bash

usage ()
{
	echo "-f or --file specifies the name of the program to change the icon for"
	echo "	search for the name on this computer and enter that example /"Spotify/""
	echo "-p or --picture to specify the path to the new icon picture must be png" 
	echo "	and should be at least 256pxx256px"
	echo "The two tags listed above are necessary for this process to work"
	echo "-h or --help to see this information again"
}

removeOldAndAddNewIcons() {
	cd ~/.local/share/
	cd ~/.local/share/icons/hicolor/
	for D in `find */apps -type d`;  
		do 
			if [ -f "$D/$2.png" ]
			then
				echo "here"
			fi 
		done
}

changeIcon() {
    sed -i "s/Icon=$2/Icon=$3/g" "$1"
	removeOldAndAddNewIcons $2 $3
}

copyDesktopFileAndIcons() {
    cd /usr/share/applications
    filename=$(grep -l -s "$1" *)
    cp $filename ~/.local/share/applications
    cd ~/.local/share/applications
    oldIcon=$(grep Icon= $filename | sed -n "s/Icon=//p")
	# Copy tree structure for hicolor and original icon files to .local
	find . -type f -name "$oldIcon" | xargs cp --parents -t ~/.local/share/icons/hicolor/
    changeIcon "$filename" "$oldIcon" "$3" 
}

homeOrShare() {
	cd ~/.local/share/applications
	filename=$(grep -l -s "$1" *)
	#Extract name from file path
	newIcon="${2##*/}"
	newIcon="${newIcon%%.png}"
	if [ ! -z "$filename" ]
	then
		oldIcon=$(grep Icon= $filename | sed -n "s/Icon=//p") 
		changeIcon $filename $oldIcon $newIcon
	else
		copyDesktopFileAndIcons "$1" "$2" "$newIcon"		
	fi
}

program=@
picture=@
while [ "$1" != "" ]; do
    case $1 in
        -f | --file )           shift
                                program=$1
                                ;;
        -p | --picture )    	shift
								picture=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

homeOrShare "$program" "$picture"

exit
