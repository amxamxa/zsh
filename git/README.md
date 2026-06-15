# maybe to add:

 https://github.com/SuperSandro2000/cheat-sheet/blob/master/misc/git.md

# Aliases

git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.branch "branch -a"
git config --global alias.ci commit
git config --global alias.c "clone --recursive"
git config --global alias.contributors "shortlog --summary --numbered"
git config --global alias.lg "log --color --decorate --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an (%G?)>%Creset' --abbrev-commit"
git config --global alias.remote "remote -v"
git config --global alias.st status
git config --global alias.tag "tag -l"

# Color

git config --global color.branch.current yellow reverse
git config --global color.branch.local yellow
git config --global color.branch.remote green
git config --global color.diff.meta yellow bold
git config --global color.diff.frag magenta bold
git config --global color.diff.old red
git config --global color.diff.new green
git config --global color.status.added green
git config --global color.status.changed yellow
git config --global color.status.untracked cyan

# Settings

git config --global apply.whitespace fix
git config --global credential.helper store
git config --global commit.gpgsign true
git config --global diff.renames copies
git config --global diff.algorithm patience
git config --global help.autocorrect 1
git config --global protocol.version 2
git config --global pull.rebase true
git config --global push.default current
git config --global user.signingkey 3AF5A43A3EECC2E5





```sh
❯ GIT_CONFIG=/share/zsh/git/config git config --list
❯ export GIT_CONFIG=/share/zsh/git/config
❯ z z
/share/zsh
❯ ga .

Fügt Änderungen hinzu

❯ gss
 __________________________________________________
/ [Git Status] \
| M  aliases.maybe                                 |
| D  history/tt                                    |
| D  history/zhistory26                            |
\ M  zsh.log                                       /
 --------------------------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

Legende:
M Modified A Staged
D Deleted R Renamed
C Copied
? Untracked
❯ gc

commit

Identität des Autors unbekannt

*** Bitte geben Sie an, wer Sie sind.

Führen Sie

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

aus, um das als Ihre standardmäßige Identität zu setzen.
Lassen Sie die Option "--global" weg, um die Identität nur
für dieses Repository zu setzen.
Schwerwiegend: Konnte die E-Mail-Adresse nicht automatisch erkennen ('amxamxa@localhorst.(none)' erhalten)
zsh: exit 128   git commit
❯ gp

Push

Everything up-to-date
❯ gc

commit

Identität des Autors unbekannt

*** Bitte geben Sie an, wer Sie sind.

Führen Sie

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

aus, um das als Ihre standardmäßige Identität zu setzen.
Lassen Sie die Option "--global" weg, um die Identität nur
für dieses Repository zu setzen.
Schwerwiegend: Konnte die E-Mail-Adresse nicht automatisch erkennen ('amxamxa@localhorst.(none)' erhalten)
zsh: exit 128   git commit
❯ echo $GIT_CONFIG
/share/zsh/git/config
❯ bap $GIT_CONFIG
# 						Konfigurationsdatei für GitHub
# 						------------------------------
#
# Dateiname: $XDG_CONFIG_HOME/git/config
# Datei enthält globale Git-Einstellungen für den Benutzer.
#	------------------------------------------------
# Bearbeiten der globalen Git-Konfiguration:
# 	git config --global --edit
# aktuellen Farbeinstellungen zu überprüfen:
# 	git config --global --get-regexp color
#	------------------------------------------------
# Erstellen eines neuen Branches basierend auf `origin/master`:
# 	git checkout -b feature/next-feature origin/master
# 	git branch -d master # Löschen des lokalen `master`-Branches:
#	-------------------------------------------------
# Setzt für `git pull` auf `rebase` (anstelle eines Merge):
# 	git config --global pull.rebase true
# Erstellt einen Alias für `git push origin HEAD`:
# git config --global alias.pu "git push origin HEAD" && git pu
#	__tshoot_________________________________________
#	GIT_CONFIG=/share/git/config git config --list
# 			und
#  	export GIT_CONFIG=/share/git/config
#	_________________________________________________
[user] 	# Name & E-Mail-Adresse des Git-Benutzer
	name = amxamxa
	email = max.kempter@gmail.com

[core]
    # Definiert das Format für Commit-Nachrichten in Logs
    formatCommit = %s %C(auto)%d by %an <%a> %C(auto)%cr

    # Pfad zur globalen .gitignore-Datei für das Ausschließen von Dateien
    excludesfile = "$GIT_CONFIG:l /.gitignore_global"

    # Steuert die Behandlung von Zeilenumbrüchen zwischen verschiedenen Betriebssystemen.
    # "input" bedeutet, dass Git CRLF-Zeilenumbrüche (Windows) in LF (Unix) umwandelt, wenn Dateien gepusht werden.
    autocrlf = input
    # Legt das End-of-Line-Zeichen fest. "lf" steht für Unix-Style (Line Feed).
    eol = lf
    # Bestimmt, ob Git Änderungen an Dateiberechtigungen berücksichtigen soll.
    # "false" bedeutet, dass Änderungen an Dateiberechtigungen ignoriert werden.
    fileMode = false
    # Steuert die Behandlung von Unicode-Zeichen.
    # "true" sorgt dafür, dass Git Unicode-Normalisierung berücksichtigt.
    precomposeunicode = true
    # Spezifiziert das Arbeitsverzeichnis für das Git-Repository.
    worktree = .
    # Definiert den Pager für die Anzeige von Git-Ausgaben.
    # "less -FRSX" zeigt nur den Output an, wenn dieser zu groß für den Bildschirm ist.
    pager = less -FRSX
    # Definiert den Pfad für benutzerdefinierte Git-Hooks (auskommentiert).
    # hookspath = ~/.git-hooks

   # Aktiviert die Nutzung von symbolischen Links.
    symlinks = true

   # Pfad zur globalen .gitignore-Datei
    # excludesfile = ~/.gitignore_global

[pretty]  # Benutzerdefinierte Formatierung für Git-Logs.
 # stdout mit Commit-Hash,  Branch, Commit-Nachricht, Alter Commit und Autor
 format = "%h %C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"

[merge]
 # Definiert das Tool für das Zusammenführen von Änderungen.
 # "colordiff" wird verwendet, um farbige Unterschiede anzuzeigen. Die verschiedenen Optionen ignorieren bestimmte Arten von Unterschieden.
 # tool = colordiff --ignore-case --ignore-tab-expansion --ignore-trailing-space --ignore-space-change --ignore-all-space --ignore-blank-lines

 # Als Alternative kann auch das Tool "meld" verwendet werden
  tool = meld

# Farbeinstellungen für verschiedene Git-Kommandos
# [color]
#     ui = auto

[color "branch"]	# Konfiguration der Farben für Branches.
    current = yellow reverse  # Aktuelle Branch 	GELB & INVERT
    local = yellow            # Lokale Branches 	GELB
    remote = green            # Remote-Branches 	GRÜN


[color "diff"]  	# Farbeinstellungen für Diffs.
    meta = yellow bold         # Meta-Informationen in 	GELB 	FETT
    frag = magenta bold        # Fragmentinformationen 	MAGENTA FETT
    old = red bold             # Alte Zeilen 			ROT 	FETT
    new = green bold           # Neue Zeilen 			GRÜN 	FETT


[color "status"]     # Farbeinstellungen für Git-Status
    added = yellow             # Hinzugefügte Dateien 	GELB
    changed = green            # Geänderte Dateien 		GRÜN
    untracked = cyan           # Nicht verfolgte Datei  CYAN

[instaweb]   		# Definiert den Standardbrowser für Git-Instaweb.
      browser = w3m

[alias]
    co = checkout              # Alias für `git checkout`.
    br = branch                # Alias für `git branch`.
    ci = commit                # Alias für `git commit`.
    st = status                # Alias für `git status`.

    # Benutzerdefiniertes Log-Format, das einen grafischen Verlauf, Commit-Informationen und Farben anzeigt.
    lg = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit

    # Alternative Log-Formatierung (auskommentiert).
    # lg = log --graph --decorate --all

    # Alias, damit beim Pushen der aktuelle Branch auf den Remote-Branch gepusht wird.
    pu = !git push origin HEAD

[pull]	   # Setzt das Verhalten für `git pull` auf Rebase, um Merge-Commits zu vermeiden.
	rebase = false
	ff = only
[push]
    autoSetupRemote = true
[init]		# Definiert den Standardbranchnamen für neue Repositories.
	defaultBranch = main

[advice]
	statusHints = on


[gui]
	wmstate = normal
	geometry = 1704x1416+12+84 207 190
```

