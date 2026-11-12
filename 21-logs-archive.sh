#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}
TIMESTAMP=$(date "+%Y-%m-%d-%H-%M-%S")

if [ -z $SOURCE_DIR ] || [ -z $DEST_DIR ]; then
    echo "ERROR:: either source_dir or dest_dir empty"
    echo "USAGE:: $0 <source_dir> <dest_dir> days"
    exit 1
fi

if [! -d $SOURCE_DIR ]; then
    echo "$SOURCE_DIR directory does not exist"
    exit 1
fi

if [ ! -d $DEST_DIR ]; then
    echo "$DEST_DIR directory does not exist"
    exit 1
fi

FILES=$(find $SOURCE_DIR -type f -name "*.log" -mtime +$DAYS)

if [ -z $FILES ]; then
    echo "$FILES no log files found older than 14 days"
    exit 0
fi

ARCHIVE_FILE=$DEST_FILE/logs-archive-$TIMESTAMP.tar.gz

tar -czvf $ARCHIVE_FILE $FILES
    if [$? -ne 0 ]; then
        echo "Archival is... success"
        while IFS= read -r FILE
        do
            echo "$FILE: file to be deleted"
            rm -rf $FILE
            echo "$FILE: file deleted"
        done <<< $FILE
    else
        echo "Archival is ...FAILED"
        