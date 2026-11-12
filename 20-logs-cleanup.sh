#!/bin/bash

SOURCE_DIR=$1
DAYS=${2-14} # default to 14 days

if [ -z "$SOURCE_DIR" ]; then
    echo "ERROR:: Missing parameters "
    echo "USAGE:: $0 <source_dir> [days(optional) to 14]"
    exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo "ERROR:: source_dir does not exist"
    exit 1
fi

FILES=$(find $SOURCE_DIR -type f -name "*.log" -mtime +$DAYS)
echo "scanning for $FILES log files older than 14 days"

if [ -z "$FILES" ]; then
    echo "no $FILES log files found older than 14 days"
    exit 0
fi

while IFS= read -r FILE
do
    echo "files to be deleted:$FILE"
    
done <<< "$FILES"
