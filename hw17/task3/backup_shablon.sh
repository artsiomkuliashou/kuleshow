#!/bin/bash
ARCHIVE_UTIL=/bin/gzip

# Check PATH !!!
HOME_DIR=/home/admin_aisr/backup/
BACKUP_DIR="$HOME_DIR"
BACKUP_DATE=`date +%Y-%m-%d`

ALIAS=$1
DATABASE=$2
FILENAME=$ALIAS$BACKUP_DATE.sql.gz
FILE1=$BACKUP_DIR$ALIAS$BACKUP_DATE.sql
FILENAME_OLD=$BACKUP_DIR$ALIAS$(date -d "14 day ago" +%Y-%m-%d).sql.gz


#DAYWEEK=`date +%u`

#FTPHOST="212.98.190.106 2121"
#FTPUSER="ihsb"
#FTPPASS="KWIZqJrd5b"
#FTPDIR="ihsb"


echo BACKUP_DIR : $BACKUP_DIR
echo BACKUP_DATE:$BACKUP_DATE
echo ALIAS      :$ALIAS
echo DATABASE   :$DATABASE
echo FILE1      :$FILE1
echo DUMP_FILENAME : $DUMP_FILENAME
echo FILENAME_OLD  : $FILENAME_OLD
echo DAYWEEK  : $DAYWEEK

echo Dumping $DATABASE to $FILE1

##pg_dump --format=plain --inserts --column-inserts --schema=bul --schema=gf --schema=teplo --schema=ver  $DATABASE> $FILE1 

pg_dump --format=custom --verbose --schema=bul --schema=gf --schema=teplo --schema=ver  $DATABASE> $FILE1 

$ARCHIVE_UTIL $FILE1

rm -f $FILENAME_OLD 


# added on 12.06.2024 to save the database DS (DS115)
BACKUP_DATE8=`date +%d%m%Y`
ALIAS8="ds"
DATABASE8="ds"
FILENAME8=$ALIAS8$BACKUP_DATE8.sql.gz
FILE8=$BACKUP_DIR$ALIAS8$BACKUP_DATE8.sql
FILENAME_OLD8=$BACKUP_DIR$ALIAS8$(date -d "14 day ago" +%d%m%Y).sql.gz
pg_dump --format=custom --verbose --schema=potrebiteli $DATABASE8> $FILE8 
$ARCHIVE_UTIL $FILE8
rm -f $FILENAME_OLD8
