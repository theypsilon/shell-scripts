#!/bin/sh

if [ "$TERM" != "screen" ] && [ -z "$TMUX" ] && ! tmux attach ; then
  tmux
fi
