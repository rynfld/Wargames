# Amateria Level 0

## Overview

We can exploit the Pickle module in order to achieve an interactive shell on the machine running the exploitable code, with the permissions of the running code as well.  The Pickle module is designed for the serialization and de-serialization of objects.  Helpfully, the module includes a means to execute commands in order to assist in unpickling the object.  We create a malicious object which, upon unpickling, spawns a subprocess that creates a shell.  In order to communicate with this shell, we alter its stdin, stdout, and stderr file descriptors to reference the file descriptor already in use by our connection.  In this way, we can send commands to the remote machine and receive the output and errors without opening any new connections.

## Helpful Commands:

Command | Description
--------|------------
ps -a | List the currently running processes
ls /proc/&ltPID>/fd/ | List the file descriptors for a given PID (process)
cat &ltfile> - | Write a file to stdout, then wait for user input (also will be written to stdout)
nc &ltaddress> <port> | connect to an address and port

## Execution

```
$ python -m exploit.py > file
$ cat file - | nc <address> <port>
root $>
```

## Notes

File descriptor 4 is the one we want to redirect our shell's stdin, stdout, and stderr too.  File descriptors 0, 1, and 2 are reserved for the usual stdin, stdout, and stderr respectiviely, and 3 is used to communicate with the port.

We have to specify the - (dash) when we send our malicious object, so as to prevent sending an EOF character from terminating the remote shell.
