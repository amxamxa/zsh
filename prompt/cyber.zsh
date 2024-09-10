# /share/zsh/prompt/cyber.zsh

 ### ------------------ ###
 ###  powerlevel10k  config
 ### ------------------ ###
   
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git  
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=false



#DIREKT FOLGENDES NICHT FÜR NIXOS:
	# to config : 	#$ p10k configure 
#if [[ -r $ZDOTDIR/powerlevel10k/powerlevel10k.zsh-theme ]];
#  then   
#    source "$ZDOTDIR/powerlevel10k/powerlevel10k.zsh-theme"   
#	POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true  
#  fi
 # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/ZSH/.zshrc. 

  # Initialization code that may require console input (password prompts, [y/n]  
  # confirmations, etc.) must go above this block; everything else may go below.  
  # if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then     source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"  fi 
  # 
 # To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.  
   #alt:    [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh  [[ ! -f $ZDOTDIR/prompt-p10.zsh ]] || source $ZDOTDIR/prompt-p10.zsh   
   
#POWERLEVEL9K_MODE="lalezar-fonts"  
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir rbenv vcs)  
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)  
# cyberpunk color schema
POWERLEVEL9K_TIME_FORMAT='%D{%H:%M}'
POWERLEVEL9K_CONTEXT_TEMPLATE=$'\ue795'  
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='#0abdc6'  # hell-türkis
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='#321959'  # dunkel-lila
POWERLEVEL9K_DIR_HOME_FOREGROUND='#0abdc6'  # hell-türkis
POWERLEVEL9K_DIR_HOME_BACKGROUND='#0b2956'  # dunkel-türkis
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='#0abdc6'  # hell-türkis
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='#0b2956'  # dunkel-türkis
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='#0abdc6'  # hell-türkis
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='#0b2956'  # dunkel-türkis
POWERLEVEL9K_DIR_ETC_FOREGROUND='#0abdc6'  # hell-türkis
POWERLEVEL9K_DIR_ETC_BACKGROUND='#0b2956'  # dunkel-türkis
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='#ea00d9'  # hell-lila
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='#321959'  # dunkel-lila
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='#f57800'  # orange
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='#321959'  # dunkel-lila
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='#00ff00'  # hell-grün
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='#321959'  # dunkel-lila
POWERLEVEL9K_STATUS_OK_BACKGROUND='#321959'  # dunkel-lila
POWERLEVEL9K_STATUS_ERROR_FOREGROUND='#ff0000'  # rot
POWERLEVEL9K_STATUS_ERROR_BACKGROUND='#321959'  # dunkel-lila
POWERLEVEL9K_HISTORY_BACKGROUND='#0b2956'  # dunkel-türkis
POWERLEVEL9K_HISTORY_FOREGROUND='#0abdc6'  # hell-türkis
POWERLEVEL9K_TIME_BACKGROUND='#321959'  # dunkel-lila
POWERLEVEL9K_TIME_FOREGROUND='#ea00d9'  # hell-lila
