#!/bin/bash

USERID=$(id -u)
#check root user or not
if [ $USERID -ne 0 ]; then
    echo "please run this script with root access"
    exit 1
fi

dnf list installed mysql
if [ $? -eq 0 ]; then
    echo "mysql is already installed ....SKIPPING"
else
    echo "installing mysql"
    dnf install mysql -y
if [ $? -ne 0 ]; then
    echo "mysql is ...FAILED"
else
    echo "mysql is ...SUCCESS"
    fi
fi

dnf list installed nginx
if [ $? -eq 0 ]; then
    echo "nginx is already installed ....SKIPPING"
else
    echo "installing nginx"
    dnf install nginx -y
if [ $? -ne 0 ]; then
    echo "nginx is ...FAILED"
else
    echo "nginx is ...SUCCESS"
    fi
fi
