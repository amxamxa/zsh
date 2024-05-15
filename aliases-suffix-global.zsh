 ### ---------------------------  #### 
 # ┌─┐┬  ┌─┐┌┐ ┌─┐┬  ┌─┐  ┌─┐┌─┐┬ ┬  ┌─┐┬  ┬┌─┐┌─┐┌─┐
 # │ ┬│  │ │├┴┐├─┤│  ├┤   ┌─┘└─┐├─┤  ├─┤│  │├─┤└─┐├┤
 # └─┘┴─┘└─┘└─┘┴ ┴┴─┘└─┘  └─┘└─┘┴ ┴  ┴ ┴┴─┘┴┴ ┴└─┘└─┘
 # ..usage % file G 'pattern'
 ### ---------------------------  #### 
 alias -g OK='~/zsh/testbed.zsh'
 alias -g ED='gnome-text-editor --ignore-session --standalone &'
 alias -g gedit='gnome-text-editor --ignore-session --standalone &'
 
 alias -g HG='--help 2>&1 | grep'
 
 alias -g N0='2> /dev/null'
 alias -g D0='2> /dev/null'
 
 
 alias -g SRC='source'
 alias -g L=' |  less'
 alias -g LL=' | less -X -j5 --tilde --save-marks \
 				--incsearch --RAW-CONTROL-CHARS \
 				--LINE-NUMBERS --line-num-width=3 \
 				--quit-if-one-screen --use-color \
 				--color=NWr --color=EwR  --color=PbC --color=Swb'
 
 alias -g G='|grep --ignore-case --color=auto' 
 
 alias -g H='--help'
 
 alias fgrep='fgrep --color=auto'
 alias  egrep='egrep --color=auto'
  #... grep ... in History auf WORD
 alias -g  h='history' 
