# filename: 		shortcuts.sh
# -----------------------------------------
# wird gesourct über zshrc
# Konfiguration für lesbare Tastenbindungen

# Teil 1
# +---------------------------------+
# | Simply mapping escape sequences |
# +---------------------------------+
# aus
# https://github.com/Phantas0s/.dotfiles/blob/master/zsh/bindings.zsh
# 
'bindkey' '-s' '^[OM'    '^M'
'bindkey' '-s' '^[Ok'    '+'
'bindkey' '-s' '^[Om'    '-'
'bindkey' '-s' '^[Oj'    '*'
'bindkey' '-s' '^[Oo'    '/'
'bindkey' '-s' '^[OX'    '='
'bindkey' '-s' '^[OA'    '^[[A'
'bindkey' '-s' '^[OB'    '^[[B'
'bindkey' '-s' '^[OD'    '^[[D'
'bindkey' '-s' '^[OC'    '^[[C'
'bindkey' '-s' '^[OH'    '^[[H'
'bindkey' '-s' '^[[1~'   '^[[H'
'bindkey' '-s' '^[[7~'   '^[[H'
'bindkey' '-s' '^[OF'    '^[[F'
'bindkey' '-s' '^[[4~'   '^[[F'
'bindkey' '-s' '^[[8~'   '^[[F'
'bindkey' '-s' '^[[3\^'  '^[[3;5~'
'bindkey' '-s' '^[^[[3~' '^[[3;3~'
'bindkey' '-s' '^[[1;9C' '^[[1;3C'
'bindkey' '-s' '^[^[[C'  '^[[1;3C'
'bindkey' '-s' '^[[1;9D' '^[[1;3D'
'bindkey' '-s' '^[^[[D'  '^[[1;3D'
'bindkey' '-s' '^[Od'    '^[[1;5D'
'bindkey' '-s' '^[Oc'    '^[[1;5C'

typeset -gA keys=(
    Up                   '^[[A'
    Down                 '^[[B'
    Right                '^[[C'
    Left                 '^[[D'
    Home                 '^[[H'
    End                  '^[[F'
    Insert               '^[[2~'
    Delete               '^[[3~'
    PageUp               '^[[5~'
    PageDown             '^[[6~'
    Backspace            '^?'

    Shift+Up             '^[[1;2A'
    Shift+Down           '^[[1;2B'
    Shift+Right          '^[[1;2C'
    Shift+Left           '^[[1;2D'
    Shift+End            '^[[1;2F'
    Shift+Home           '^[[1;2H'
    Shift+Insert         '^[[2;2~'
    Shift+Delete         '^[[3;2~'
    Shift+PageUp         '^[[5;2~'
    Shift+PageDown       '^[[6;2~'
    Shift+Backspace      '^?'
    Shift+Tab            '^[[Z'

    Alt+Up               '^[[1;3A'
    Alt+Down             '^[[1;3B'
    Alt+Right            '^[[1;3C'
    Alt+Left             '^[[1;3D'
    Alt+End              '^[[1;3F'
    Alt+Home             '^[[1;3H'
    Alt+Insert           '^[[2;3~'
    Alt+Delete           '^[[3;3~'
    Alt+PageUp           '^[[5;3~'
    Alt+PageDown         '^[[6;3~'
    Alt+Backspace        '^[^?'

    Alt+Shift+Up         '^[[1;4A'
    Alt+Shift+Down       '^[[1;4B'
    Alt+Shift+Right      '^[[1;4C'
    Alt+Shift+Left       '^[[1;4D'
    Alt+Shift+End        '^[[1;4F'
    Alt+Shift+Home       '^[[1;4H'
    Alt+Shift+Insert     '^[[2;4~'
    Alt+Shift+Delete     '^[[3;4~'
    Alt+Shift+PageUp     '^[[5;4~'
    Alt+Shift+PageDown   '^[[6;4~'
    Alt+Shift+Backspace  '^[^H'

    Ctrl+Up              '^[[1;5A'
    Ctrl+Down            '^[[1;5B'
    Ctrl+Right           '^[[1;5C'
    Ctrl+Left            '^[[1;5D'
    Ctrl+Home            '^[[1;5H'
    Ctrl+End             '^[[1;5F'
    Ctrl+Insert          '^[[2;5~'
    Ctrl+Delete          '^[[3;5~'
    Ctrl+PageUp          '^[[5;5~'
    Ctrl+PageDown        '^[[6;5~'
    Ctrl+Backspace       '^H'

    Ctrl+Shift+Up        '^[[1;6A'
    Ctrl+Shift+Down      '^[[1;6B'
    Ctrl+Shift+Right     '^[[1;6C'
    Ctrl+Shift+Left      '^[[1;6D'
    Ctrl+Shift+Home      '^[[1;6H'
    Ctrl+Shift+End       '^[[1;6F'
    Ctrl+Shift+Insert    '^[[2;6~'
    Ctrl+Shift+Delete    '^[[3;6~'
    Ctrl+Shift+PageUp    '^[[5;6~'
    Ctrl+Shift+PageDown  '^[[6;6~'
    Ctrl+Shift+Backspace '^?'

    Ctrl+Alt+Up          '^[[1;7A'
    Ctrl+Alt+Down        '^[[1;7B'
    Ctrl+Alt+Right       '^[[1;7C'
    Ctrl+Alt+Left        '^[[1;7D'
    Ctrl+Alt+Home        '^[[1;7H'
    Ctrl+Alt+End         '^[[1;7F'
    Ctrl+Alt+Insert      '^[[2;7~'
    Ctrl+Alt+Delete      '^[[3;7~'
    Ctrl+Alt+PageUp      '^[[5;7~'
    Ctrl+Alt+PageDown    '^[[6;7~'
    Ctrl+Alt+Backspace   '^[^H'

    Ctrl+Alt+Shift+Up        '^[[1;8A'
    Ctrl+Alt+Shift+Down      '^[[1;8B'
    Ctrl+Alt+Shift+Right     '^[[1;8C'
    Ctrl+Alt+Shift+Left      '^[[1;8D'
    Ctrl+Alt+Shift+Home      '^[[1;8H'
    Ctrl+Alt+Shift+End       '^[[1;8F'
    Ctrl+Alt+Shift+Insert    '^[[2;8~'
    Ctrl+Alt+Shift+Delete    '^[[3;8~'
    Ctrl+Alt+Shift+PageUp    '^[[5;8~'
    Ctrl+Alt+Shift+PageDown  '^[[6;8~'
    Ctrl+Alt+Shift+Backspace '^?'
    # hat die zkbd Funktion gesagt, Egebnis von $ autoload -Uz zkbd; zkbd;
     	F1    	'^[OP'
	F2	'[OQ'
	F3	'^[OR'
	F4	'^[OS'
	F5	'^[[15~'
	F6	'^[[17~'
	F7 	'^[[18~'
	F8	'^[[19~'
	F9	'^[[20~'
	F10	'^[[21~'
	F11	'^[[23~'
	F12	'^[[24~'
  )

bindkey -- "${keys[Home]}"            .beginning-of-line
bindkey -- "${keys[End]}"             .end-of-line
bindkey -- "${keys[Insert]}"          .overwrite-mode
bindkey -- "${keys[Backspace]}"       .backward-delete-char
bindkey -- "${keys[Delete]}"          .delete-char
bindkey -- "${keys[Up]}"              .up-line-or-history
bindkey -- "${keys[Down]}"            .down-line-or-history
bindkey -- "${keys[Left]}"            .backward-char
bindkey -- "${keys[Right]}"           .forward-char
bindkey -- "${keys[PageUp]}"          .beginning-of-buffer-or-history
bindkey -- "${keys[PageDown]}"        .end-of-buffer-or-history
bindkey -- "${keys[Shift+Tab]}"       .reverse-menu-complete
bindkey -- "${keys[Ctrl+Left]}"       .backward-word
bindkey -- "${keys[Ctrl+Right]}"      .forward-word




#Teil 2
 
# mxx  zsh-Shortcuts
# showkey --ascii
# showkex
# cat  # dann 

bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
# Zeile vor Cursor löschen 
bindkey '^U' backward-kill-line
# Zeile nach Cursor löschen
bindkey '^K' kill-line
# Wortweise Cursor bewegen, ALT+b / +f
bindkey '^[b' backward-word 
bindkey '^[f' forward-word
#------------------
# nötig? 
# Wort löschen 
# bindkey '^W' backward-kill-word
# Gelöschtes wieder einfügen
# bindkey '^Y' yank
# Alt+R - Entfernt letztes Wort  
# bindkey '^[r' kill-word

# Ctrl+_ - Kapitalisiert das aktuelle Wort
# bindkey '^_' capitalize-word
# Alt+E - Editiert den aktuellen Befehl in $EDITOR
# bindkey '^[e' edit-command-line
# Alt+# - Kommentiert die aktuelle Zeile aus
# bindkey '^[#' pound-insert

# Alt+N - Sucht Dateien in aktuellen Ordnern
# bindkey '^[N' list-files
# Ctrl+F - Sucht vorwärts
#bindkey '^F' 
# Ctrl+B - Sucht rückwärts  
#bindkey '^B'
# Löscht Bildschirm
bindkey '^L' clear-screen

# Historiennavigation
bindkey '^R' history-incremental-search-backward
#bindkey '^P' up-line-or-search
#bindkey '^N' down-line-or-search
bindkey '^[W' which-command
bindkey '^[I' where-is 

# Teil 3
# zsh-autosuggestions iterate through suggestions 
# based on current substring using up/down arrow keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search


#	______________________________________________
#      Globale Suffix-Aliases erweitern
#    ---------------------------------------------
globalias() {
	# Aliases erweitern aka sehen kann, mit Leertaste
			if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
				zle _expand_alias
				zle expand-word
			fi
			zle self-insert
		}
	zle -N globalias
	bindkey " " globalias # Die Funktion an die Leertaste binden
	# control-space to bypass completion
	bindkey "^ " magic-space   # Bindung für Control+Space, um die Expansion zu umgehen
	
		# normal space during searches       
		bindkey -M isearch " " magic-space 
	# sonstige Shortcuts in File ~/zsh/shortcuts.zsh


# Ende ___________________________

