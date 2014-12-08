#!/bin/sh

# Detached shell, an improved 'command &'
# Usage: ds [commands]
readonly LOG_FILE="$HOME/.ds.log"

# Invocation with no arguments
if [ $# -eq 0 ]; then
    if [ -f $LOG_FILE ]; then
        cat $LOG_FILE
        echo; echo "# Log stored in $LOG_FILE"
    else
        echo "No arguments supplied"
    fi
    exit
fi

# Redirect stderr and stdout
if test -t 1; then exec 1>>$LOG_FILE; fi
if test -t 2; then exec 2>>$LOG_FILE; fi

# Log makeup
if [ -f $LOG_FILE ]; then echo; fi

# For date command
LANG=en_US

# Logging input
echo "[$(date) | $PWD ]>\$ $@"

# Logging output
"$@" &