# That`s a pack of my bash scripts
____
## backup_filetype.sh ##

**This script can create an compressed copy of one or more directories with filetype filter (if needed) and variable compression level.**

```
Arguments:
-h - help
-s - source dir
-d - destination dir
-c - compression level
-i - include files by mask
-e - exclude files by mask
```

* Example 1: ./test.sh -d /backup_vol/destination/ -s "/tmp/source1 /tmp/source2" -i "zip"
Creates backup in '/backup_vol/destination/'. Directories '/tmp/source1' and '/tmp/source2' are source directories, included only .zip files

* Example 2: ./test.sh -d /backup_vol/destination/ -s "/tmp/source1" -e "jpeg"
Creates backup in '/backup_vol/destination/'. Directory '/tmp/source1' is a source directory, saved all files but .jpeg`s

* Example 3: ./test.sh -d /backup_vol/destination/ -s "/tmp/source1" -c 2
Creates backup in '/backup_vol/destination/'. Directory '/tmp/source1' is a source directory, saved all files, compression level 2 (1 is for fastest processing, 9 is for best compression)
 <br />
Archives older than 14 days are automatically rotated (see last line of the script).

____
## bacula_check.sh ##

**This script checks availability of bacula CLI and restarts services if CLI is not available.**  <br />
<br />
Use case: from time to time you are experiencing some connectivity problems with database, so bacula can not run backup jobs.

____
## change_pass.sh ##
**This script changes password for root (or any other) linux account for a list of machines. Just in case you need to periodically change passwords.** <br />
<br />
Usage: ./change_pass.sh list_of_machines.txt

____
## chmod.sh
**This script sets identical access rights for a directory between two machines.** <br />

<br />Use case: First machine is used as a reference and the second one has incorrect access rights for some directory caused by operator`s error. <br />

<br />Usage:
```
Arguments:
-h - help
-s - set access rights from file
-g - get reference access rights
-f - file with reference access rights
-t - target directory for grab reference access rights
```
____
## deploy_cron_script.sh ##
**This script copies another script to a list of machines and adds a crontab job.**<br />
<br />Usage: './script.sh servers_list.txt'

____
## ldap_dump.sh ##
**This script makes a compressed copy of LDAP database by 'slapcat -l' and rotates old backups.**

____
## service_check.sh ##
**Simple script for check service state and restart if needed. Just add it to the crontab.**
