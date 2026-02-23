# --- Section Notes ---
export NOTES_DIR="$NK_DIR/notes"

if [ -d "$NOTES_DIR/.git" ]; then
    ( builtin cd "$NOTES_DIR" && git pull --quiet &> /dev/null & )
fi

alias brain="cd $NOTES_DIR && smart-editor $NOTES_DIR"
alias cdn="cd $NOTES_DIR"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
