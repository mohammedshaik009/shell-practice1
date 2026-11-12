#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$1
DAYS=${2:-14} #default to 14 days
TIMESTAMP=$(date "+%Y-%m-%d %H-%M-%S")

if [ -z "$SOURCE_DIR" ] || [ -z "$DEST_DIR" ]; then
    echo "ERROR:: Missing either source_dir or Dest_dir"
    echo "USAGE:: $0 <source_dir> <dest_dir>"
    exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo "$SOURCE_DIR directory does not exist"
    exit 1
fi

if [ ! -d "$DEST_DIR" ]; then
    echo "$DEST_DIR directory does not exist"
    exit 1
fi

FILES=$(find $SOURCE_DIR -type f -name "*.log" -mtime +$DAYS)

if [ -z "$FILES" ]; then
    echo "no log files found older than 14 days"
    exit 0
fi

ARCHIVE_FILE=$DEST_DIR/logs-archive-$TIMESTAMP.tar.gz

tar -czvf $LOGS_ARCHIVE $FILES

    if [ $? -eq 0 ]; then
        echo "archival is success"
        while IFS= read -r FILE
        do
            echo "$FILE: file to be deleted"
                  rm -rf $FILE
            echo "$FILE: files deleted"
         done <<< "$FILES"
    else
            echo "archival is FAILED"
    fi