#!/bin/bash

LOGS_FOLDER=/var/log/roboshop
LOGS_FILE="$LOGS_FOLDER/$0.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USERID=$(id -u)
#check root user or not
if [ $USERID -ne 0 ]; then
    echo -e "$TIMESTAMP [ERROR] $R please run this script with root access $N" | tee -a $LOGS_FILE
    exit 1
fi

VALIDATE(){
    if [ $2 -ne 0 ]; then
        echo -e "$TIMESTAMP [ERROR] installing $1 is ...$R FAILED $N" | tee -a $LOGS_FILE
    else
        echo -e "$TIMESATMP [INFO] installing $1 is ...$G SUCCESS $N" | tee -a $LOGS_FILE
    fi    
}
dnf list installed mysql &>> $LOGS_FILE
if [ $? -eq 0 ]; then
    echo -e "$TIMESATMP [INFO] mysql is already installed ....$Y SKIPPING $N"
else
    echo "installing mysql"
    dnf install mysql -y  &>> $LOGS_FILE
    VALIDATE mysql $?
fi

dnf list installed nginx  &>> $LOGS_FILE
if [ $? -eq 0 ]; then
    echo -e "$TIMESTAMP [INFO] nginx is already installed ....$Y SKIPPING $N"
else
    echo "installing nginx"
    dnf install nginx -y &>> $LOGS_FILE
    VALIDATE nginx $?
fi
