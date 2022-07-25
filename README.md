# That`s a pack of my bash scripts
____
## Backup_filetype.sh

This script can create an compressed copy of few directories with filetype filter (if needed) and variable compression level.

```
Arguments:
-h - help
-s - source dir
-d - destination dir
-c - compression level
-i - include files by mask
-e - exclude files by mask
```

Example 1: ./test.sh -d /backup_vol/destination/ -s "/tmp/source1 /tmp/source2" -i "zip"
Creates backup in '/backup_vol/destination/'. Directories '/tmp/source1' and '/tmp/source2' are source directories, included only .zip files

Example 2: ./test.sh -d /backup_vol/destination/ -s "/tmp/source1 /tmp/source2" -i "zip"
