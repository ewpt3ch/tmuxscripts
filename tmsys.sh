#!/bin/bash
##################################
# tmux start script for system   #
# author eric at ewpt3ch dot com #
##################################

# usage: system.sh

# check if we're in a tmux session, prevent nesting
if [[ "$TMUX" != "" ]]; then
  echo -e "Error: cannot nest sessions \e[3meventualy want to detach and start new"
  exit
fi

session="system"

# check if system session already exists
if (tmux has-session -t ${session} 2> /dev/null); then
  echo -e "${session} already exists"
  exit
fi

# not in a session not session already name session
# so lets create it

cd "${HOME}"
tmux new-session -d -s "${session}" -n "htop"
tmux split-window -v -p 20 -t "${session}"
tmux send-keys -t "${session}:1.1" "htop" C-m
tmux send-keys -t "${session}:1.2" "pacupg" C-m
tmux new-window -n "journal" -t "${session}"
tmux split-window -v -p 30 -t "${session}:2"
tmux send-keys -t "${session}:2.1" "journalctl -f" C-m
tmux new-window -n "scratch" -t "${session}"

# finally attach to the new session
tmux attach-session -t "${session}"
