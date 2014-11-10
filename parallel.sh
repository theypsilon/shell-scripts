#!/bin/sh

set -e

if [ $# -lt 2 ]; then
	echo "Usage: $0 placeholderfile command"
	echo "Example: $0 servers.txt ssh [] ls /var/log"
	exit 1
fi

file=$1

shift

arguments="$@"

get_command() {
	local regexp="s/\[\]/"$1"/g"
	local result="$(echo $arguments | sed -e $regexp)"
	printf $result
}

while read line
do
	$(get_command $line) > $line.log 2>&1 &
done < $file

wait

while read line
do
	echo $(get_command $line) && cat $line.log && rm $line.log
done < $file