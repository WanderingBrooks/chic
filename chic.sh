#!/bin/bash

function usage
{
	echo "-f or --file specifies the name of the program to change the icon for"
	echo "	search for the name on this computer and enter that example /"Spotify/""
	echo "-p or --picture to specify the path to the new icon picture must be png" 
	echo "	and should be at least 256pxx256px"
	echo "The two tags listed above are necessary for this process to work"
	echo "-h or --help to see this information again"
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

applications=~/.local/share/applications
cd $applications
filename=$(grep -l -s $program *)
oldIcon=$(grep Icon= $filename | sed -n "s/Icon=//p")
#Extract name from file path
newIcon="${picture##*/}"
newIcon="${newIcon%%.png}"

sed -i "s/Icon=$oldIcon/Icon=$newIcon/g" $filename

exit
