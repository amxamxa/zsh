



############################################################################### Resize an image
# arg1: the file
# arg2: the width to resize
# arg3: modify the file in place
# Example: imgresize myimage.jpg 780 true
imgresize() {
    local filename=${1%\.*}
    local extension="${1##*.}"
    local separator="_"
    if [ ! -z $3 ]; then
        local finalName="$filename.$extension"
    else
        local finalName="$filename$separator$2.$extension"
    fi
    convert $1 -quality 100 -resize $2 $finalName
    echo "$finalName resized to $2"
}

Imgresize() {
    imgresize $1 $2 true
}

# Resize all images
# arg1: the extension of all images
# arg2: the width to resize
# arg3: modify the files in place
# Example: imgresizeall jpg 780 true
imgresizeall() {
    for f in *.${1}; do
        if [ ! -z $3 ]; then
            imgresize "$f" ${2} t
        else
            imgresize "$f" ${2}
        fi
    done
}

imginvert() {
    local filename=${1%\.*}
    local extension="${1##*.}"
    local separator="_"
    local invert="inverted"
    if [ ! -z $2 ]; then
        local finalName="$filename.$extension"
    else
        local finalName="$filename$separator$invert.$extension"
    fi
    convert $1 -channel RGB -negate $finalName
    echo "$finalName inverted"
}

imgoptimize() {
    local filename=${1%\.*}
    local extension="${1##*.}"
    local separator="_"
    local suffix="optimized"
    local finalName="$filename$separator$suffix.$extension"
    convert $1 -strip -interlace Plane -quality 85% $finalName
    echo "$finalName created"
}

Imgoptimize() {
    local filename=${1%\.*}
    local extension="${1##*.}"
    local separator="_"
    local suffix="optimized"
    local convert $1 -strip -interlace Plane -quality 85% $1
    echo "$1 created"
}

imgoptimizeall() {
    for f in *.${1}; do
        imgoptimize "$f"
    done
}

Imgoptimizeall() {
    for f in *.${1}; do
        Imgoptimize "$f"
    done
}

imgtojpg() {
    for file in "$@"
    do
        local filename=${file%\.*}
        convert -quality 100 $file "${filename}.jpg"
    done
}

imgtopng() {
    for file in "$@"
    do
        local filename=${file%\.*}
        convert -quality 100 $file "${filename}.png"
    done
}

imgtowebp() {
    for file in "$@"
    do
        local filename=${file%\.*}
        cwebp -q 100 $file -o $(basename ${filename}).webp
    done
}

##########################################################################
# Extract files
extract() {
    for file in "$@"
    do
        if [ -f $file ]; then
            _ex $file
        else
            echo "'$file' is not a valid file"
        fi
    done
}

# Extract files in their own directories
mkextract() {
    for file in "$@"
    do
        if [ -f $file ]; then
            local filename=${file%\.*}
            mkdir -p $filename
            cp $file $filename
            cd $filename
            _ex $file
            rm -f $file
            cd -
        else
            echo "'$1' is not a valid file"
        fi
    done
}

# Internal function to extract any file
_ex() {
    case $1 in
        *.tar.bz2)  tar xjf $1      ;;
        *.tar.gz)   tar xzf $1      ;;
        *.bz2)      bunzip2 $1      ;;
        *.gz)       gunzip $1       ;;
        *.tar)      tar xf $1       ;;
        *.tbz2)     tar xjf $1      ;;
        *.tgz)      tar xzf $1      ;;
        *.zip)      unzip $1        ;;
        *.7z)       7z x $1         ;; # require p7zip
        *.rar)      7z x $1         ;; # require p7zip
        *.iso)      7z x $1         ;; # require p7zip
        *.Z)        uncompress $1   ;;
        *)          echo "'$1' cannot be extracted" ;;
    esac
}

# Compress a file 
# TODO to improve to compress in any possible format
# TODO to improve to compress multiple files
compress() {
    local DATE="$(date +%Y%m%d-%H%M%S)"
    tar cvzf "$DATE.tar.gz" "$@"
} # Spit the size of images
imgsize() {
    for file in "$@"
    do
        local width=$(identify -format "%w" "$file")> /dev/null
        local height=$(identify -format "%h" "$file")> /dev/null

        echo -e "Size of $file: $width*$height"
    done
}



