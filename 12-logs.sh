#!/bin/bash

LOGS_FOLDER=/var/log/roboshop
LOGS_FILE="$LOGS_FOLDER/$0.log"

USERID=$(id -u)
#check root user or not
if [ $USERID -ne 0 ]; then
    echo "please run this script with root access"
    exit 1
fi

VALIDATE(){
    if [ $2 -ne 0 ]; then
        echo "$1 is ...FAILED"
    else
        echo "$1 is ...SUCCESS"
    fi    
}
dnf list installed mysql &>> $LOGS_FILE
if [ $? -eq 0 ]; then
    echo "mysql is already installed ....SKIPPING"
else
    echo "installing mysql"
    dnf install mysql -y  &>> $LOGS_FILE
    VALIDATE mysql $?
fi

dnf list installed nginx  &>> $LOGS_FILE
if [ $? -eq 0 ]; then
    echo "nginx is already installed ....SKIPPING"
else
    echo "installing nginx"
    dnf install nginx -y &>> $LOGS_FILE
    VALIDATE $? nginx
fi
