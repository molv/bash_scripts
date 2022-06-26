#!/bin/bash
##############################
## https://github.com/molv ##
##############################
#
#This script can create an compressed copy of few directories with filetype filter and variable compression level.
#
#Example:
#./test.sh -d /backup_vol/destination/ -s "/tmp/source1 /tmp/source2" -i "zip"


#create temp
TMP_DIR=/tmp/backup_tmp
[[ -d $TMP_DIR ]] || echo "Creating temp $TMP_DIR" && mkdir -p $TMP_DIR


#functions#############################################################
usage() 
{
    echo -e "USAGE: \n -s "/SOURCE1 /SOURCE2 etc..." \n -d "/DESTINATION" \n -i include by filetype "txt jpg etc... " \n -e exclude by filetype "txt jpg etc... " \n -c {compression value from 1 {faster} to 9 {better compression}} "
}

copy_mask_include ()
{
#echo " executing function_include: $SRC_LIST/*.$INCLUDE_FILES $TMP_DIR/"
mkdir -p $TMP_DIR/$SRC_LIST/
find $SRC_LIST -type f -name "*.$INCLUDE_FILES" | xargs cp -t $TMP_DIR/$SRC_LIST/ #2>/dev/null
find $TMP_DIR/$SRC_LIST -type d -empty -delete
}

copy_mask_excude ()
{
#echo " executing function_exclude: $SRC_LIST/*.$EXCLUDE_FILES $TMP_DIR/"
mkdir -p $TMP_DIR/$SRC_LIST/
find $SRC_LIST -type f ! -name "*.$EXCLUDE_FILES" | xargs cp -t $TMP_DIR/$SRC_LIST/ #2>/dev/null
find $TMP_DIR/$SRC_LIST/ -type d -empty -delete
}

copy_no_mask ()
{
#echo " executing function_copy_no_mask: $SRC_LIST to $TMP_DIR"
cp -R $SRC_LIST $TMP_DIR
}


#options#############################################################
while getopts ":s:d:c:i:e:hh:" arg
do
  case $arg in
    h)  usage ; exit 0 ;; #how to use
    s)  SRC=${OPTARG} ;;  #source dir
    d)  DST=${OPTARG} ;;  #destination dir 
    c)  GZIP=-${OPTARG} ;; #compression ratio
    i)  INCLUDE=${OPTARG} ;; #include files by mask
    e)  EXCLUDE=${OPTARG} ;; #exclude files by mask
  esac
done

#set compression = 5 if not defined
if
    [[ -z $GZIP ]];
        then
            GZIP=-5
            echo "compression = $GZIP"

fi

#Stop execution if destination dir is not defined
if
    [[ -z $DST ]];
        then
            echo "Destination directory is not defined"
            exit 1

fi

#use /etc as source if it is not defined
if
    [[ -z $SRC ]];
        then
            echo 'Source is not set, using /etc'
            SRC=/etc
fi

#determine the type of backup: include/exclude filetypes of full backup

#full
if
    [[ -z $INCLUDE ]] && [[ -z $EXCLUDE ]];
        then
            echo 'Executing full copy'
            for SRC_LIST in ${SRC}; do
                echo $SRC_LIST
                copy_no_mask
            done

#if there is included file types
elif
    [[ -n $INCLUDE ]];
        then
            echo 'Executing copy by include'
            for SRC_LIST in ${SRC}; do
                echo "Copying from: $SRC_LIST to $TMP_DIR"
                    for INCLUDE_FILES in ${INCLUDE}; do
                        copy_mask_include
                    done
            done

#if there is excluded file types
elif
    [[ -n $EXCLUDE ]];
        then
            echo 'Executing copy by exclude'
            for SRC_LIST in ${SRC}; do
                echo "Copying from: $SRC_LIST to $TMP_DIR"
                    for EXCLUDE_FILES in ${EXCLUDE}; do
                        copy_mask_excude
                    done
            done
fi

echo 'Compressing archive...'
tar -czf $DST/backup_archive_`date +"%Y_%m_%d-%H_%M"`.tar.gz $TMP_DIR

unset GZIP

echo 'Removing temp'
rm -rf $TMP_DIR

echo  "Rotating archives in $DST older, than 14 days"
find $DST -type f -mtime -name "backup_archive_*" +14 -delete
