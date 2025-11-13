#!/bin/bash
ARCHIVE_UTIL=/bin/gzip

# Check PATH !!!
mount -t cifs -o credentials=/home/admin_aisr/.connect //192.168.100.212/backups/srv-aisr /home/admin_aisr/backup_share/
HOME_DIR=/home/admin_aisr/backup_share/
BACKUP_DIR="$HOME_DIR"

DATABASE=$1
ALIAS=$2
FILENAME=$BACKUP_DIR$DATABASE_$ALIAS.sql
FILE1=$FILENAME.gz

echo BACKUP_DIR :$BACKUP_DIR
echo ALIAS      :$ALIAS
echo DATABASE   :$DATABASE
echo FILE1      :$FILE1

echo Dumping $DATABASE to $FILE1

##pg_dump --format=plain --inserts --column-inserts --schema=bul --schema=gf --schema=teplo --schema=ver  $DATABASE> $FILE1 

sudo -u postgres pg_dump --format=custom --verbose --schema=bul --schema=gf --schema=teplo --schema=ver --exclude-table-data=bul.i_bazob --exclude-table-data=gf.bevent  $DATABASE> $FILENAME


