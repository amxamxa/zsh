#!/usr/bin/env zsh
###########################################
##  filename:    	dircolors.zsh
##  filepath:     	/home/ZSH
##  author:       	mxx
##  file save date:   
##  file creation date [yy-mmm]: 23 dez
##  file status		 work in progess
##  comments: 	   - 

## NUR TESTZWECKE!!

###########################################
### Farbkonfiguration für ls
# default Farbkonfig
#export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36"

# cyberpunk
#export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*.di=01;30:*.ln=01;30:*.mh=00:*.pi=40;33:*.so=01;32"

# cyberpunk 2
#export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"

# Farbkonfiguration von KALI
export LS_COLORS="rs=0:di=01;35:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"
command ls -Al --color=always
sleep 2

command eza -Al
sleep 2



## rxvt-256color 
# # cyberpunk 2
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"
command ls -Al --color=always
sleep 2

command eza -Al
sleep 2

export LS_COLORS='di=1;35:ln=1;36:so=1;44:pi=1;33:ex=1;32:bd=5;33:cd=5;33:su=0;41:sg=0;46:tw=0;42:ow=0;43*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'; export LS_COLORS
command ls -Al --color=always
sleep 2

command eza -Al
sleep 2


export LS_COLORS='di=1;35:ln=1;36:so=1;44:pi=1;33:ex=1;32:bd=5;33:cd=5;33:su=0;41:sg=0;46:tw=0;42:ow=0;43*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'
command ls -Al --color=always
sleep 2

command eza -Al
sleep 2

export LS_COLORS='su=0;38;2;241;250;140;48;2;255;121;198:ex=0;38;2;80;250;123:ow=0;38;2;139;233;253;48;2;40;42;54:ln=0;38;2;139;233;253:tw=0;38;2;241;250;140;48;2;80;250;123:pi=1;38;2;241;250;140;48;2;40;42;54:rs=0;38;2;255;184;108:ca=0:cd=1;38;2;255;184;108;48;2;40;42;54:di=0;38;2;189;147;249:sg=0;38;2;241;250;140;48;2;255;121;198:mi=0;38;2;255;85;85;48;2;40;42;54:st=0;38;2;241;250;140;48;2;139;233;253:mh=0:no=0;38;2;248;248;242:so=1;38;2;241;250;140;48;2;40;42;54:do=1;38;2;241;250;140;48;2;40;42;54:fi=0;38;2;248;248;242:*~=0;38;2;58;60;78:or=0;38;2;255;85;85;48;2;40;42;54:bd=1;38;2;255;184;108;48;2;40;42;54:*.c=0;38;2;255;184;108:*.m=0;38;2;255;184;108:*.z=1;38;2;189;147;249:*.d=0;38;2;255;184;108:*.o=0;38;2;58;60;78:*.r=0;38;2;255;184;108:*.t=0;38;2;255;184;108:*.a=0;38;2;80;250;123:*.h=0;38;2;255;184;108:*.p=0;38;2;255;184;108:*.kt=0;38;2;255;184;108:*.el=0;38;2;255;184;108:*.hh=0;38;2;255;184;108:*.ps=0;38;2;255;184;108:*.la=0;38;2;58;60;78:*.cr=0;38;2;255;184;108:*.vb=0;38;2;255;184;108:*.fs=0;38;2;255;184;108:*.cp=0;38;2;255;184;108:*.7z=1;38;2;189;147;249:*.sh=0;38;2;255;184;108:*.rm=1;38;2;255;184;108:*.rb=0;38;2;255;184;108:*.jl=0;38;2;255;184;108:*.pm=0;38;2;255;184;108:*.wv=0;38;2;255;184;108:*.gz=1;38;2;189;147;249:*.mn=0;38;2;255;184;108:*css=0;38;2;255;184;108:*.md=0;38;2;255;184;108:*.ko=0;38;2;80;250;123:*.td=0;38;2;255;184;108:*.di=0;38;2;255;184;108:*.hs=0;38;2;255;184;108:*.rs=0;38;2;255;184;108:*.gv=0;38;2;255;184;108:*.js=0;38;2;255;184;108:*.bz=1;38;2;189;147;249:*.hi=0;38;2;58;60;78:*.ml=0;38;2;255;184;108:*.nb=0;38;2;255;184;108:*.cc=0;38;2;255;184;108:*.so=0;38;2;80;250;123:*.ex=0;38;2;255;184;108:*.as=0;38;2;255;184;108:*.cs=0;38;2;255;184;108:*.go=0;38;2;255;184;108:*.lo=0;38;2;58;60;78:*.py=0;38;2;255;184;108:*.pp=0;38;2;255;184;108:*.bc=0;38;2;58;60;78:*.ll=0;38;2;255;184;108:*.ui=0;38;2;255;184;108:*.ts=0;38;2;255;184;108:*.xz=1;38;2;189;147;249:*.pl=0;38;2;255;184;108:*.tar=1;38;2;189;147;249:*.csv=0;38;2;255;184;108:*.swf=1;38;2;255;184;108:*.erl=0;38;2;255;184;108:*.eps=0;38;2;241;250;140:*.avi=1;38;2;255;184;108:*.mli=0;38;2;255;184;108:*.dot=0;38;2;255;184;108:*.xml=0;38;2;255;184;108:*.pdf=0;38;2;255;184;108:*.arj=1;38;2;189;147;249:*.flv=1;38;2;255;184;108:*.odp=0;38;2;255;184;108:*.tml=0;38;2;255;184;108:*.bak=0;38;2;58;60;78:*.blg=0;38;2;58;60;78:*.rst=0;38;2;255;184;108:*.exs=0;38;2;255;184;108:*.pod=0;38;2;255;184;108:*.xmp=0;38;2;255;184;108:*.git=0;38;2;58;60;78:*.bag=1;38;2;189;147;249:*.pas=0;38;2;255;184;108:*.elm=0;38;2;255;184;108:*.lua=0;38;2;255;184;108:*TODO=1;38;2;255;184;108:*.bmp=0;38;2;241;250;140:*.wma=0;38;2;255;184;108:*.com=0;38;2;80;250;123:*.csx=0;38;2;255;184;108:*.pyd=0;38;2;58;60;78:*.pro=0;38;2;255;184;108:*.tsx=0;38;2;255;184;108:*.out=0;38;2;58;60;78:*.fon=0;38;2;255;184;108:*.tex=0;38;2;255;184;108:*.awk=0;38;2;255;184;108:*.clj=0;38;2;255;184;108:*.vcd=1;38;2;189;147;249:*.mov=1;38;2;255;184;108:*.c++=0;38;2;255;184;108:*.svg=0;38;2;241;250;140:*.fnt=0;38;2;255;184;108:*.bib=0;38;2;255;184;108:*.vim=0;38;2;255;184;108:*.rpm=1;38;2;189;147;249:*.exe=0;38;2;80;250;123:*.mid=0;38;2;255;184;108:*.dpr=0;38;2;255;184;108:*.apk=1;38;2;189;147;249:*.aux=0;38;2;58;60;78:*.bsh=0;38;2;255;184;108:*.jar=1;38;2;189;147;249:*.fsi=0;38;2;255;184;108:*.ilg=0;38;2;58;60;78:*.rar=1;38;2;189;147;249:*.mkv=1;38;2;255;184;108:*.jpg=0;38;2;241;250;140:*.vob=1;38;2;255;184;108:*.zst=1;38;2;189;147;249:*.log=0;38;2;58;60;78:*.nix=0;38;2;255;184;108:*.hxx=0;38;2;255;184;108:*.fsx=0;38;2;255;184;108:*.htc=0;38;2;255;184;108:*.cgi=0;38;2;255;184;108:*.bst=0;38;2;255;184;108:*.ipp=0;38;2;255;184;108:*.swp=0;38;2;58;60;78:*.bbl=0;38;2;58;60;78:*.odt=0;38;2;255;184;108:*.kts=0;38;2;255;184;108:*.ini=0;38;2;255;184;108:*.gvy=0;38;2;255;184;108:*.zsh=0;38;2;255;184;108:*.sxw=0;38;2;255;184;108:*.cpp=0;38;2;255;184;108:*.ps1=0;38;2;255;184;108:*.inl=0;38;2;255;184;108:*.epp=0;38;2;255;184;108:*.pyo=0;38;2;58;60;78:*.cfg=0;38;2;255;184;108:*.tgz=1;38;2;189;147;249:*.php=0;38;2;255;184;108:*.pbm=0;38;2;241;250;140:*.tcl=0;38;2;255;184;108:*.m4a=0;38;2;255;184;108:*.ltx=0;38;2;255;184;108:*.hpp=0;38;2;255;184;108:*.zip=1;38;2;189;147;249:*.pkg=1;38;2;189;147;249:*hgrc=0;38;2;255;184;108:*.pid=0;38;2;58;60;78:*.mir=0;38;2;255;184;108:*.bz2=1;38;2;189;147;249:*.toc=0;38;2;58;60;78:*.idx=0;38;2;58;60;78:*.pps=0;38;2;255;184;108:*.iso=1;38;2;189;147;249:*.h++=0;38;2;255;184;108:*.wav=0;38;2;255;184;108:*.sxi=0;38;2;255;184;108:*.ico=0;38;2;241;250;140:*.kex=0;38;2;255;184;108:*.ttf=0;38;2;255;184;108:*.xls=0;38;2;255;184;108:*.doc=0;38;2;255;184;108:*.tmp=0;38;2;58;60;78:*.xcf=0;38;2;241;250;140:*.mp3=0;38;2;255;184;108:*.bcf=0;38;2;58;60;78:*.mpg=1;38;2;255;184;108:*.htm=0;38;2;255;184;108:*.txt=0;38;2;255;184;108:*.sty=0;38;2;58;60;78:*.cxx=0;38;2;255;184;108:*.ods=0;38;2;255;184;108:*.inc=0;38;2;255;184;108:*.tif=0;38;2;241;250;140:*.otf=0;38;2;255;184;108:*.wmv=1;38;2;255;184;108:*.dmg=1;38;2;189;147;249:*.sbt=0;38;2;255;184;108:*.bat=0;38;2;80;250;123:*.pgm=0;38;2;241;250;140:*.aif=0;38;2;255;184;108:*.pyc=0;38;2;58;60;78:*.rtf=0;38;2;255;184;108:*.fls=0;38;2;58;60;78:*.ppt=0;38;2;255;184;108:*.bin=1;38;2;189;147;249:*.def=0;38;2;255;184;108:*.gif=0;38;2;241;250;140:*.psd=0;38;2;241;250;140:*.ogg=0;38;2;255;184;108:*.ind=0;38;2;58;60;78:*.img=1;38;2;189;147;249:*.png=0;38;2;241;250;140:*.deb=1;38;2;189;147;249:*.tbz=1;38;2;189;147;249:*.ics=0;38;2;255;184;108:*.yml=0;38;2;255;184;108:*.m4v=1;38;2;255;184;108:*.dll=0;38;2;80;250;123:*.asa=0;38;2;255;184;108:*.xlr=0;38;2;255;184;108:*.mp4=1;38;2;255;184;108:*.dox=0;38;2;255;184;108:*.sql=0;38;2;255;184;108:*.ppm=0;38;2;241;250;140:*.mpeg=1;38;2;255;184;108:*.lock=0;38;2;58;60;78:*.hgrc=0;38;2;255;184;108:*.conf=0;38;2;255;184;108:*.diff=0;38;2;255;184;108:*.psd1=0;38;2;255;184;108:*.yaml=0;38;2;255;184;108:*.webm=1;38;2;255;184;108:*.json=0;38;2;255;184;108:*.opus=0;38;2;255;184;108:*.xlsx=0;38;2;255;184;108:*.rlib=0;38;2;58;60;78:*.toml=0;38;2;255;184;108:*.lisp=0;38;2;255;184;108:*.jpeg=0;38;2;241;250;140:*.tiff=0;38;2;241;250;140:*.make=0;38;2;255;184;108:*.pptx=0;38;2;255;184;108:*.docx=0;38;2;255;184;108:*.epub=0;38;2;255;184;108:*.orig=0;38;2;58;60;78:*.bash=0;38;2;255;184;108:*.java=0;38;2;255;184;108:*.h264=1;38;2;255;184;108:*.html=0;38;2;255;184;108:*.fish=0;38;2;255;184;108:*.psm1=0;38;2;255;184;108:*.tbz2=1;38;2;189;147;249:*.dart=0;38;2;255;184;108:*.less=0;38;2;255;184;108:*.purs=0;38;2;255;184;108:*.flac=0;38;2;255;184;108:*.class=0;38;2;58;60;78:*.cmake=0;38;2;255;184;108:*.xhtml=0;38;2;255;184;108:*.cabal=0;38;2;255;184;108:*.patch=0;38;2;255;184;108:*.swift=0;38;2;255;184;108:*README=0;38;2;255;184;108:*.dyn_o=0;38;2;58;60;78:*.cache=0;38;2;58;60;78:*.mdown=0;38;2;255;184;108:*passwd=0;38;2;255;184;108:*.toast=1;38;2;189;147;249:*.ipynb=0;38;2;255;184;108:*.scala=0;38;2;255;184;108:*.shtml=0;38;2;255;184;108:*shadow=0;38;2;255;184;108:*COPYING=0;38;2;255;184;108:*LICENSE=0;38;2;255;184;108:*.dyn_hi=0;38;2;58;60;78:*.flake8=0;38;2;255;184;108:*.config=0;38;2;255;184;108:*.ignore=0;38;2;255;184;108:*.matlab=0;38;2;255;184;108:*TODO.md=1;38;2;255;184;108:*.gradle=0;38;2;255;184;108:*INSTALL=0;38;2;255;184;108:*.groovy=0;38;2;255;184;108:*TODO.txt=1;38;2;255;184;108:*.desktop=0;38;2;255;184;108:*Makefile=0;38;2;255;184;108:*setup.py=0;38;2;255;184;108:*Doxyfile=0;38;2;255;184;108:*.gemspec=0;38;2;255;184;108:*COPYRIGHT=0;38;2;255;184;108:*.cmake.in=0;38;2;255;184;108:*.kdevelop=0;38;2;255;184;108:*.fdignore=0;38;2;255;184;108:*configure=0;38;2;255;184;108:*.DS_Store=0;38;2;58;60;78:*.markdown=0;38;2;255;184;108:*README.md=0;38;2;255;184;108:*.rgignore=0;38;2;255;184;108:*.gitignore=0;38;2;255;184;108:*SConstruct=0;38;2;255;184;108:*.gitconfig=0;38;2;255;184;108:*README.txt=0;38;2;255;184;108:*.scons_opt=0;38;2;58;60;78:*.localized=0;38;2;58;60;78:*INSTALL.md=0;38;2;255;184;108:*CODEOWNERS=0;38;2;255;184;108:*Dockerfile=0;38;2;255;184;108:*SConscript=0;38;2;255;184;108:*INSTALL.txt=0;38;2;255;184;108:*Makefile.am=0;38;2;255;184;108:*.synctex.gz=0;38;2;58;60;78:*Makefile.in=0;38;2;58;60;78:*LICENSE-MIT=0;38;2;255;184;108:*.travis.yml=0;38;2;255;184;108:*MANIFEST.in=0;38;2;255;184;108:*.gitmodules=0;38;2;255;184;108:*CONTRIBUTORS=0;38;2;255;184;108:*.applescript=0;38;2;255;184;108:*configure.ac=0;38;2;255;184;108:*appveyor.yml=0;38;2;255;184;108:*.fdb_latexmk=0;38;2;58;60;78:*.clang-format=0;38;2;255;184;108:*CMakeCache.txt=0;38;2;58;60;78:*CMakeLists.txt=0;38;2;255;184;108:*LICENSE-APACHE=0;38;2;255;184;108:*.gitattributes=0;38;2;255;184;108:*CONTRIBUTORS.md=0;38;2;255;184;108:*CONTRIBUTORS.txt=0;38;2;255;184;108:*requirements.txt=0;38;2;255;184;108:*.sconsign.dblite=0;38;2;58;60;78:*package-lock.json=0;38;2;58;60;78:*.CFUserTextEncoding=0;38;2;58;60;78'
command ls -Al --color=always
sleep 2

command eza -Al
sleep 2

