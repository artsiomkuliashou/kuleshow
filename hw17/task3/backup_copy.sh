#!/bin/bash
mount -t cifs -o vers=2.0,credentials=/home/admin_aisr/.connect //192.168.100.87/backup-DB/srv-aisr /home/admin_aisr/backup_share/

FROM_DIR=/home/admin_aisr/backup/
TO_DIR=/home/admin_aisr/backup_share/
BACKUP_DATE1=`date +%Y-%m-%d`
BACKUP_DATE2=`date +%d%m%Y`
ALIAS1="mkts"
ALIAS2="ds"
FILENAME1=$ALIAS1$BACKUP_DATE1.sql.gz
FILENAME1_OLD=$ALIAS1$(date -d "14 day ago" +%Y-%m-%d).sql.gz
FILENAME2=$ALIAS2$BACKUP_DATE2.sql.gz
FILENAME2_OLD=$ALIAS2$(date -d "14 day ago" +%d%m%Y).sql.gz

cp $FROM_DIR$FILENAME1 $TO_DIR
rm -f $TO_DIR$FILENAME1_OLD
cp $FROM_DIR$FILENAME2 $TO_DIR
rm -f $TO_DIR$FILENAME2_OLD
