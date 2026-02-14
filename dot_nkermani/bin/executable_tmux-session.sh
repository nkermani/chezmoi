#!/bin/bash

SESSION_NAME="nkermani"

tmux has-session -t $SESSION_NAME 2>/dev/null

if [ $? != 0 ]; then
  tmux new-session -d -s $SESSION_NAME -n "nvim"
  tmux send-keys -t $SESSION_NAME:1 "cd ~/Documents/dev/ && nvim ." C-m

  tmux new-window -t $SESSION_NAME:2 -n "opencode"
  tmux send-keys -t $SESSION_NAME:2 "opencode" C-m

  tmux new-window -t $SESSION_NAME:3 -n "notes"
  tmux send-keys -t $SESSION_NAME:3 "brain" C-m

  tmux new-window -t $SESSION_NAME:4 -n "chezmoi"
  tmux send-keys -t $SESSION_NAME:4 "chezmoi cd" C-m

  tmux select-window -t $SESSION_NAME:1
fi

tmux attach-session -t $SESSION_NAME
