#!/bin/bash
##################################
# tmux start script for cmus     #
# author eric at ewpt3ch dot com #
##################################

# usage: tmcmus.sh

session="cmus"

# check if we're in a tmux session, prevent nesting
if [[ "$TMUX" != "" ]]; then
  echo -e "Error: cannot nest sessions \e[3meventualy want to detach and start new"
  exit
fi

# check if session by session already exists
if (tmux has-session -t ${session} 2> /dev/null); then
  echo -e "${session} already exists"
  exit
fi

# not in a session already named cmus 
# so lets create it and not attach, let it be in the backgound

tmux new-session -d -s "${session}" -n "cmus"
tmux split-window -v -p 20 -t "${session}"
tmux send-keys -t "${session}:1.1" "cmus" C-m
