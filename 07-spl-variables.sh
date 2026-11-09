#!/bin/bash

echo "all variables passed to this script:$@"
echo "number of variables passed:$#"
echo "first variable:$1"
echo "PID of the script:$$"
echo "name of the script:$0"
echo "directory of the script:$HOME"
echo "who is running this script:$USER"
echo "pwd of the script:$PWD"
sleep 10 &
echo "PID of the command running just now:$!"
wait $!
echo "line number of the script:$LINENO"
echo "random number of the script:$RANDOM"
echo "exit code of the previous command:$?"
echo "script executed in seconds:$SECONDS"
