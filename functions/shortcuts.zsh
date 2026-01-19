# ZSH KEYBINDINGS KONFIGURATION MIT KOMMENTAREN
# -------------------------------------------
# Diese Datei definiert umfassende Tastenbindungen ("keybindings") für die Zsh-Shell.
# Ziel ist eine möglichst umfassende Unterstützung für Tastaturinteraktion, inklusive Modifier (Ctrl, Alt, Shift), Funktionstasten und Navigation.
# Die Konfiguration wurde sorgfältig an eine Kitty-Terminal-Umgebung angepasst.

# ------------------------------------------------------------
# Abschnitt 1: Tastenübersetzungen (Terminal Escape-Sequenzen normalisieren)
# ------------------------------------------------------------
# Einige Terminals senden verschiedene Escape-Sequenzen für dieselbe Taste
# oder benötigen Übersetzungen, damit Zsh die Eingabe korrekt interpretiert.

bindkey -s '^[OM' '^M'     # Enter-Taste (Numeric Keypad)
bindkey -s '^[Ok' '+'      # Numpad Plus
bindkey -s '^[Om' '-'      # Numpad Minus
bindkey -s '^[Oj' '*'      # Numpad Asterisk
bindkey -s '^[Oo' '/'      # Numpad Slash
bindkey -s '^[OX' '='      # Numpad Equal

# Richtungstasten & Navigation
bindkey -s '^[OA' '^[[A'   # Pfeil hoch (Alternate Mode)
bindkey -s '^[OB' '^[[B'   # Pfeil runter
bindkey -s '^[OD' '^[[D'   # Pfeil links
bindkey -s '^[OC' '^[[C'   # Pfeil rechts
bindkey -s '^[OH' '^[[H'   # Pos1 (Home)

# Home-/End-Taste in verschiedenen Modi
bindkey -s '^[[1~' '^[[H'
bindkey -s '^[[7~' '^[[H'
bindkey -s '^[OF' '^[[F'
bindkey -s '^[[4~' '^[[F'
bindkey -s '^[[8~' '^[[F'

# Erweitertes Verhalten für Löschen mit Modifikatoren
bindkey -s '^[[3\^'  '^[[3;5~'    # Ctrl+Entf
bindkey -s '^[^[[3~' '^[[3;3~'    # Alt+Entf

# Alt+Pfeiltasten Mappings (vereinheitlicht)
bindkey -s '^[[1;9C' '^[[1;3C'    # Alt+Right
bindkey -s '^[^[[C'  '^[[1;3C'    # Alt+Right (alternative Sequenz)
bindkey -s '^[[1;9D' '^[[1;3D'    # Alt+Left
bindkey -s '^[^[[D'  '^[[1;3D'    # Alt+Left (alternative)

# Ctrl+Pfeiltasten (alternative Sequenzen vom Keypad)
bindkey -s '^[Od' '^[[1;5D'       # Ctrl+Left
bindkey -s '^[Oc' '^[[1;5C'       # Ctrl+Right

# ------------------------------------------------------------
# Abschnitt 2: Mapping von Escape-Sequenzen auf symbolische Namen
# ------------------------------------------------------------
# Dies erleichtert das spätere Binden mit bindkey -- ${keys[Name]}
typeset -gA keys=(
  # Navigation
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

  # Modifiziert: Shift + Navigation
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

  # Alt + Navigation
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

  # Ctrl + Navigation
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

  # Funktionstasten
  F1 '^[OP'
  F2 '[OQ'
  F3 '^[OR'
  F4 '^[OS'
  F5 '^[[15~'
  F6 '^[[17~'
  F7 '^[[18~'
  F8 '^[[19~'
  F9 '^[[20~'
  F10 '^[[21~'
  F11 '^[[23~'
  F12 '^[[24~'
)

# ------------------------------------------------------------
# Abschnitt 3: Konkrete Tastenzuweisungen zu zle-Widgets
# ------------------------------------------------------------
# Diese Verknüpfungen verbinden Escape-Sequenzen mit interaktiven zsh-Editorbefehlen

bindkey -- "${keys[Home]}"            beginning-of-line
bindkey -- "${keys[End]}"             end-of-line
bindkey -- "${keys[Insert]}"          overwrite-mode
bindkey -- "${keys[Backspace]}"       backward-delete-char
bindkey -- "${keys[Delete]}"          delete-char
bindkey -- "${keys[Up]}"              up-line-or-history
bindkey -- "${keys[Down]}"            down-line-or-history
bindkey -- "${keys[Left]}"            backward-char
bindkey -- "${keys[Right]}"           forward-char
bindkey -- "${keys[PageUp]}"          beginning-of-buffer-or-history
bindkey -- "${keys[PageDown]}"        end-of-buffer-or-history
bindkey -- "${keys[Shift+Tab]}"       reverse-menu-complete
bindkey -- "${keys[Ctrl+Left]}"       backward-word
bindkey -- "${keys[Ctrl+Right]}"      forward-word

# Standard Emacs-ähnliche Shortcuts
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^U' backward-kill-line
bindkey '^K' kill-line
bindkey '^[b' backward-word
bindkey '^[f' forward-word
bindkey '^L' clear-screen
bindkey '^R' history-incremental-search-backward
bindkey '^[W' which-command
bindkey '^[I' where-is

# ------------------------------------------------------------
# Abschnitt 4: Erweiterte Suche: History-Suche ab Cursorposition
# ------------------------------------------------------------
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# ------------------------------------------------------------
# Abschnitt 5: GLOBALIAS: automatische Alias-Expansion bei Großbuchstaben
# ------------------------------------------------------------
# Wenn das zuletzt eingegebene Wort (vor dem Leerzeichen) ein Alias in Großbuchstaben ist,
# wird es automatisch expandiert, sobald die Leertaste gedrückt wird.
# Dadurch können globale Aliase wie "GIT" → "git status" verwendet werden.

# Magic-Space: CMDs mit Großbuchstaben-Aliasen (auch am Anfang) automatisch expandieren
globalias() {
  local lastword prefix
  prefix=${LBUFFER##* }  # Letztes Wort
  if [[ -z $LBUFFER ]]; then
    zle self-insert
    return
  fi

  #  Wenn das letzte Wort oder das erste Wort Großbuchstaben enthält
  if [[ $prefix =~ '^[A-Z0-9_]+$' || $LBUFFER =~ '^([A-Z0-9_]+)( |$)' ]]; then
    zle _expand_alias
    zle expand-word
  fi

  zle self-insert
}
zle -N globalias
bindkey " " globalias

# Auch in der Suche (Ctrl+R) aktivieren
bindkey -M isearch " " magic-space
bindkey "^ " magic-space  # Optional: Ctrl+Space


