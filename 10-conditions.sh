#!/bin/bash

# -gt -> greater than
# -ge -> greater than or equal
# -nt -> not equal
# -eq -> equal
# -lt -> less than
# -le -> less than or equal

NUMBER=$1

if [ $NUMBER -gt 20 ]; then
    echo "given number $NUMBER is greater than 20"
elif [ $NUMBER -eq 20 ]; then
    echo "given number $NUMBER is equal to 20"
else
    echo "given number $NUMBER is less than 20"
fi