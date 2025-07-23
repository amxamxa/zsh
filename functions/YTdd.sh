#!/usr/bin/env bash

# ======================================================================
# YouTube Audio Downloader Script
# Autor: Ihr Name
# Version: 1.0
# Beschreibung: Lädt YouTube-Videos/Playlists als MP3 mit Metadaten und Thumbnail
# Sicherheitshinweise:
#   - Nur von vertrauenswürdigen Quellen ausführen
#   - URLs sollten auf offizielle YouTube-Links beschränkt bleiben
#   - Skript benötigt Internetzugriff und yt-dlp
# ======================================================================

# Check for required parameter
if [ $# -lt 1 ]; then
    echo "Error: No URL provided!"
    echo "Usage: $0 <youtube_url> [audio-quality]"
    exit 1
fi

# Set default audio quality
QUALITY="128k"
if [ $# -ge 2 ]; then
    case "$2" in
        192k|256k)
            QUALITY="$2"
            ;;
        *)
            echo "Invalid audio quality! Using default 128k"
            ;;
    esac
fi

# Normalize URL format
URL="${1}"
# Remove existing quotes
URL="${URL%\"}"
URL="${URL#\"}"
# Add quotes to handle special characters
NORMALIZED_URL="\"${URL}\""

# Set output template
OUTPUT_TEMPLATE="%(title)s.%(ext)s"

# Function to show filename preview
show_preview() {
    echo -e "\n\033[1;34mFilename Preview:\033[0m"
    eval "yt-dlp --get-filename -o \"$OUTPUT_TEMPLATE\" -x --audio-format mp3 ${NORMALIZED_URL}"
}

# User interaction loop
while true; do
    show_preview
    
    read -p $'\n\033[1;33mAre the filenames correct? [Y/n/change]\033[0m ' -r REPLY
    
    case $REPLY in
        [Yy]|"")
            break
            ;;
        [Nn])
            read -p $'\033[1;33mAbort process? [Y/n]\033[0m ' -r ABORT
            [[ $ABORT =~ ^[Yy]?$ ]] && exit 0
            ;;
        [Cc]|change)
            read -p $'\033[1;33mEnter new naming template (e.g. '\''%(title)s - %(artist)s.%(ext)s'\''):\033[0m ' OUTPUT_TEMPLATE
            ;;
        *)
            echo "Invalid option!"
            ;;
    esac
done

# Execute download command
echo -e "\n\033[1;32mStarting download...\033[0m"
eval "yt-dlp --progress --sponsorblock-remove all --audio-quality $QUALITY --audio-format mp3 -x --embed-metadata --embed-thumbnail --no-mtime -o \"$OUTPUT_TEMPLATE\" $NORMALIZED_URL"

echo -e "\n\033[1;32mDownload completed successfully!\033[0m"

