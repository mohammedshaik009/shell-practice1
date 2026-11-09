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
        echo -e "$TIMESTAMP [INFO] installing $1 is ...$G SUCCESS $N" | tee -a $LOGS_FILE
    fi    
}

for instance in $@
do
        echo "installing $instance"
        dnf list installed $instance &>> $LOGS_FILE
    if [ $? -ne 0 ]; then
        dnf install $instance -y  &>> $LOGS_FILE
        VALIDATE "installing $instance" $?
    else
        echo -e "$TIMESTAMP $instance is already installed ...$Y skipping $N"
    fi
done