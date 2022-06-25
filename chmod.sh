#!/bin/bash
##############################
## https://github.com/molv ##
##############################

#This script is used to copy access right between two servers for a set of files in case of accidental chmod/chown

usage ()
{
echo -e "How to use: \n -h help \n -g get chmod \n -s set chmod \n -f output/source ACL file \n -t target dir"
}

get_chmod ()
{
find $TARGET -print0|xargs -0  stat --format '%n|%a|%U|%G' > $FILE #|sed 's! !\\ !g' > $FILE
}

set_chmod ()
{
while IFS="|" read -r FILE_PATH DIGITS OWNER GROUP;do
#echo "filepath = $FILE_PATH"
#echo "chmod = $DIGITS"
#echo "owner = $OWNER"
#echo "group = $GROUP"
echo "setting ACL for $FILE_PATH"
chown $OWNER:$GROUP "$FILE_PATH"
chmod $DIGITS "$FILE_PATH"
done < $FILE
}

while getopts "gsf:t:h" arg
do
  case $arg in
    h)  usage ; exit 0 ;; #how to use
    s)  SETCHM=TRUE ;;  #set chmod
    g)  GETCHM=TRUE ;;  #get chmod
    f)  FILE=${OPTARG} ;; #destination/source ACL file
    t)  TARGET=${OPTARG} ;; #directory for grab ACL
  esac
done

#if no options was given - show help
if [[ $# -lt 1  ]]
    then
        usage
        exit 1
fi

#get access data and write to file
if
    [[ -z $SETCHM ]] && [[ -n $GETCHM ]] && [[ -n $FILE ]] && [[ -n $TARGET ]];
        then
            echo "Getting data"
            echo "Output file  = $FILE"
            get_chmod
            exit 0

fi

#write access data
if
    [[ -z $GETCHM ]] && [[ -n $SETCHM ]] && [[ -n $FILE ]];
        then
            set_chmod
            exit 0

fi

if
    [[ -n $FILE ]] && [[ -z $GETCHM ]] && [[ -n $TARGET ]] || [[ -z $SETCHM ]] && [[ -n $FILE ]] && [[ -n $TARGET ]];
        then
            echo "No get\set option was given"
            exit 1

fi

if
    [[ -z $TARGET ]] && [[ -n $FILE ]];
        then
            echo "No target dir"
            exit 1

fi

if
    [[ -z $FILE ]] && [[ -n $TARGET ]];
        then
            echo "No ACL file was given"
            exit 1

fi

if
    [[ -z $FILE ]] && [[ -z $TARGET ]];
        then
            echo "No ACL file and target dir"
            exit 1

fi
