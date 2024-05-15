# zsh-Shortcuts
# showkey --ascii



# Pos1
bindkey '^A' beginning-of-line
# Ende
bindkey '^E' end-of-line
# Zeile vor Cursor löschen 
bindkey '^U' backward-kill-line
# Zeile nach Cursor löschen
bindkey '^K' kill-line
# Wort löschen 
bindkey '^W' backward-kill-word
# Gelöschtes wieder einfügen
bindkey '^Y' yank
# Wortweise Cursor bewegen, ALT+b / +f
bindkey '^[b' backward-word 
bindkey '^[f' forward-word
# Alt+R - Entfernt letztes Wort  
bindkey '^[r' kill-word
# Ctrl+_ - Kapitalisiert das aktuelle Wort
bindkey '^_' capitalize-word

# Alt+E - Editiert den aktuellen Befehl in $EDITOR
bindkey '^[e' edit-command-line
# Alt+# - Kommentiert die aktuelle Zeile aus
bindkey '^[#' pound-insert

# Alt+N - Sucht Dateien in aktuellen Ordnern
bindkey '^[n' list-files
# Ctrl+F - Sucht vorwärts
bindkey '^F' forward-char
# Ctrl+B - Sucht rückwärts  
bindkey '^B' backward-char
# Löscht Bildschirm
bindkey '^L' clear-screen

# Historiennavigation
bindkey '^R' history-incremental-search-backward
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search

bindkey '^[C' which-command
bindkey '^[I' where-is 

