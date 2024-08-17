

#################################################
#		╔═╗╦═╗╔═╗╔╦╗╔═╗╔╦╗
#zsh -	╠═╝╠╦╝║ ║║║║╠═╝ ║ 
#		╩  ╩╚═╚═╝╩ ╩╩   ╩ 
#################################################

#!!!! " prompt off "  before setting your prompt. 
# otherwise will interact wired w/config
# prompt off

 ### ------------------ ###
 ###  lecacy prompt
 ### ------------------ ###
   
# Benutzerdefinierter Prompt mit Git-Branch und Exit-Status
 #function prompt_info() {
 #    local exit_status="%(?..%F{red}%?%f)"
 #     local git_branch="%{$fg[cyan]%}%F{240}%f%B%1v%b%f"
 # 
 #     PS1="$exit_status$git_branch> "
 # }
# 
 # PROMPT=prompt_info
  autoload -Uz promptinit
   promptinit
   prompt bigfade



