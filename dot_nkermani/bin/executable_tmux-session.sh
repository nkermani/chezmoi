#!/bin/bash

SESSION_NAME="nkermani"

# 1. Vérifier si tmux est installé
if ! command -v tmux >/dev/null 2>&1; then
	echo "Erreur : tmux n'est pas installé."
	exit 1
fi

# 2. Créer la session si elle n'existe pas
tmux has-session -t $SESSION_NAME 2>/dev/null

if [ $? != 0 ]; then
	# Création de la session en arrière-plan (-d)
	# On force l'usage de /bin/zsh pour éviter les surprises
	tmux new-session -d -s $SESSION_NAME -n "nvim" || {
		echo "Erreur : Impossible de créer la session tmux '$SESSION_NAME'."
		exit 1
	}

	# On vérifie si le dossier existe avant de CD
	if [ -d "$HOME/Documents/dev/" ]; then
		tmux send-keys -t $SESSION_NAME:1 "cd ~/Documents/dev/ && nvim ." C-m
	else
		tmux send-keys -t $SESSION_NAME:1 "nvim" C-m
	fi

	tmux new-window -t $SESSION_NAME:2 -n "opencode"
	# Vérifie si opencode est une commande valide avant d'envoyer
	if command -v opencode >/dev/null 2>&1; then
		tmux send-keys -t $SESSION_NAME:2 "opencode ." C-m
	fi

	tmux new-window -t $SESSION_NAME:3 -n "notes"
	if command -v brain >/dev/null 2>&1; then
		tmux send-keys -t $SESSION_NAME:3 "brain" C-m
	fi

	tmux new-window -t $SESSION_NAME:4 -n "chezmoi"
	if command -v chezmoi >/dev/null 2>&1; then
		tmux send-keys -t $SESSION_NAME:4 "chezmoi cd" C-m
	fi

	tmux select-window -t $SESSION_NAME:1
fi

# 3. Attachement sécurisé
if [[ -n "$TMUX" ]]; then
	exit 0
fi

tmux attach-session -t $SESSION_NAME || {
	echo "Erreur : Impossible de s'attacher à la session '$SESSION_NAME'."
}
