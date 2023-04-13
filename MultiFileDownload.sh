#!/bin/bash
#$ ./MultiFileDownload.sh give chmod +x permission before use. 
#Enter host URL: http://192.168.119.172:8080
#Enter file names (separated by space): PowerUp.exe PowerView.elf JuicyPotato.py
#Enter destination directory: ./Downloads

# Display ASCII art with color
echo -e "\033[1;36m"
cat << "EOF"
 ,---,---,---,---,---,---,---,---,---,---,---,---,
| Y | a | v | u | z |   | S | a | h | b | a | z |   |
|---'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-|
|     ___                                             __
|   /   \           ___ ___   ____ ___  ____   _____/  |_
|   \_   \   ______\  \\  \_/ ___\\  \/  /  _ \ /    \   __\
|   /   /  /_____/  >  <\___ \\___ \>    <\_\ \_\   |  |
|  /___/           /__/ /____/_____/__/\_ \___  /___|  /
|                                       \/    \/     \/
|---,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'--|
| Y | a | v | u | z |   | S | a | h | b | a | z |   |
 `---'---'---'---'---'---'---'---'---'---'---'---'---'
EOF
echo -e "\033[0m"

# Get input values
read -p "Enter host URL: " host_url
read -p "Enter file names (separated by space): " -a file_names
read -p "Enter destination directory: " destination

# Function to download files using curl
download_curl() {
    curl -O "$1" &
}

# Function to download files using wget
download_wget() {
    wget "$1" &
}

# Check which downloader (curl or wget) is available
if command -v curl >/dev/null; then
    downloader="curl"
elif command -v wget >/dev/null; then
    downloader="wget"
else
    echo "Neither curl nor wget is available. Please install one of them and try again."
    exit 1
fi

# Ensure the destination folder exists
if [[ ! -d "$destination" ]]; then
    mkdir -p "$destination"
fi

# Download files using the available downloader
cd "$destination"
for file_name in "${file_names[@]}"; do
    url="${host_url}/${file_name}"
    echo "Downloading $url to $destination"

    if [[ "$downloader" == "curl" ]]; then
        download_curl "$url"
    elif [[ "$downloader" == "wget" ]]; then
        download_wget "$url"
    fi
done

# Wait for all background processes (downloads) to finish
wait

echo "All downloads completed using $downloader."
