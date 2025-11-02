#!/bin/bash

if [ "$(id -u)" != 0 ]; then
echo "root permissions required" >&2
exit 1
fi

#Variables
file=/var/users
shell=/sbin/nologin

#Functions
create_user() {
    groupadd $groupname 2>/dev/null
    useradd -m -g $groupname $username -s $shell 2>/dev/null
    passwd -d $username 2>/dev/null
    echo "Done! User: $username, Group: $groupname"
}

add_sudo_access() {
    # for group it and security
    if [[ "$groupname" =~ ^(it|security)$ ]]; then
        if ! grep -q "%$groupname" /etc/sudoers; then
            cp /etc/sudoers{,.bkp}
            echo "%$groupname ALL=(ALL) ALL" >> /etc/sudoers
        fi
        shell=/bin/bash
    fi
    
    # for user admin
        if [[ "$username" = "admin" ]]; then
        if ! grep -q "$username" /etc/sudoers; then
            cp /etc/sudoers{,.bkp}
            echo "$username ALL=(ALL) ALL" >> /etc/sudoers
        fi
        shell=/bin/bash
    fi
}

if [ ! -z $2 ]; then
    username=$1 groupname=$2
    echo "Username: $username Group: $groupname"
    create_user
    add_sudo_access
elif [ -f $file ]; then
    IFS=$'\n'
    for line in $(cat $file); do
        username=$(echo $line | cut -d' ' -f1)
        groupname=$(echo $line | cut -d' ' -f2)
        echo "Username: $username Group: $groupname"
        create_user
        add_sudo_access
    done
else
    read -p "Print username: " username
    read -p "Print groupname: " groupname
    echo "Username: $username Group: $groupname"
    create_user
    add_sudo_access
fi