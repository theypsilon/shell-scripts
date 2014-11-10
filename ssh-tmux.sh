#!/bin/sh

set -e

if [ $# -lt 1 ]; then
    echo "Usage: $0 hostfile"
    exit 1
fi

connect_to_servers() {
    local hostfile=$1
    local first_pane_command=""

    while read server
    do
        local ssh_command="exec ssh $server"
        if [ -z "$first_pane_command" ]; then
            first_pane_command=$ssh_command
        else
            local pane_command="tmux split-window -h '$ssh_command'"
            eval $pane_command
            tmux select-layout tiled > /dev/null 2>&1
        fi
    done < $hostfile
        
    tmux set-window-option synchronize-panes on && clear && eval $first_pane_command
}

connect_to_servers $1