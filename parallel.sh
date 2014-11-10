#!/bin/sh

set -e

if [ $# -lt 2 ]; then
	echo "Usage: $0 placeholderfile command"
	echo "Example: $0 servers.txt ssh _ ls /var/log"
	exit 1
fi

file=$1

shift

arguments="$@"

get_command() {
	local result=${arguments//_/$1}
	printf "$result"
}

while read line
do
	$(get_command $line) &> $line.log &
done < $file

wait

while read line
do
	echo $(get_command $line) && cat $line.log && rm $line.log
done < $file