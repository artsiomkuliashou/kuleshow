#!/bin/bash

shell=/sbin/nologin
echo "Welcome!"

read -p "Print username: " username
read -p "Print groupname: " groupname

# Создаем группу
groupadd $groupname
if [ "$groupname" = it] then
 cp /etc/sudoers{,.bkp}
 echo '%'$groupname' ALL=(ALL) ALL' >> /etc/sudoers
 shell=/bin/bash
fi
# Создаем пользователя с домашней директорией
useradd -m -g $groupname $username -s $shell

# Устанавливаем пароль
passwd $username

echo "Done! User: $username, Group: $groupname"
