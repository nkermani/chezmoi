#!/bin/bash

SESSION_NAME="nkermani"

tmux has-session -t $SESSION_NAME 2>/dev/null

if [ $? != 0 ]; then
	tmux new-session -d -s $SESSION_NAME -n "nvim"
	tmux send-keys -t $SESSION_NAME:1 "cd ~/Documents/dev/ && nvim ." C-m

	tmux new-window -t $SESSION_NAME:2 -n "opencode"
	tmux send-keys -t $SESSION_NAME:2 "opencode --internal" C-m

	tmux new-window -t $SESSION_NAME:3 -n "notes"
	tmux send-keys -t $SESSION_NAME:3 "brain" C-m

	tmux new-window -t $SESSION_NAME:4 -n "chezmoi"
	tmux send-keys -t $SESSION_NAME:4 "chezmoi cd" C-m

	tmux select-window -t $SESSION_NAME:1

	# Lancer la fenêtre Alacritty dédiée pour opencode (dezoomée)
	# On utilise alacritty.exe (Windows) et on empêche le loop via SKIP_TMUX_AUTOSTART
	alacritty.exe -o "font.size=10" -e wsl.exe zsh -c "export SKIP_TMUX_AUTOSTART=1; tmux attach-session -t $SESSION_NAME \; select-window -t opencode" &
fi

tmux attach-session -t $SESSION_NAME
