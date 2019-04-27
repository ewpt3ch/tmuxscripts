#!/bin/bash
######################################
# tmux start script for dev projects #
# author eric at ewpt3ch dot com     #
######################################

# usage: dev.sh session

# check for a session
if [[ -z $1 ]]; then
  echo -e "you need to name the session ie dev.sh \e[3msession"
  exit
fi

session=$1

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

# set GOPATH/bin in PATH
PATH="${GOPATH}/bin:${PATH}"
# not in a session not session already name session
# so lets create it

tmux new-session -d -s "${session}" -n "edit"
tmux split-window -v -p 20 -t "${session}"
tmux new-window -n "servers" -t "${session}"
tmux split-window -v -t "${session}:2"
tmux new-window -n "scratch" -t "${session}"
tmux send-keys -t "${session}:3.1" "git status" C-m

# finally attach to the new session
tmux attach-session -t "${session}"
