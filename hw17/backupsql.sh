#!/bin/bash
#запуск только от имени postgres
#перед созданием crontab убедитесь что пользователь postgres имеет право на использование sudo прав для команд "cp" и "chown" без ввода пароля
#для копирования в другую папку можно поменять имя пользователя на другое так же как и в строке назначения прав
name_db=$1
backup_file=/var/lib/postgresql/backups/backup_"$name_db"_$(date +%Y-%m).sql
backup_copy=/home/artem-kuleshow/backups_sql/backup_"$name_db"_$(date +%Y-%m).sql

#создание дампа 
/usr/bin/pg_dump $name_db > $backup_file

#копирование файла дампа базы данных
sudo cp $backup_file $backup_copy
sudo chown artem-kuleshow:artem-kuleshow $backup_copy
