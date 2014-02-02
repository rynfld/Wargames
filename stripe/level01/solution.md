# Stripe-CTF Level 01

## Overview

Looking at the source code, we can see that the program calls system() to execute the "date" command.  If we replace the "date" command with a command of our own design, we can execute code to create a shell with the same permissions as those of the exploitable program.  The system() function uses the PATH environment variable to search for the command; by placing the directory containing our malicious "date" command before the rest of the directories in PATH, the system() function will find ours first and execute it.

## Execution

```
$> export PATH=.:$PATH
$> ./level01
root $>
'''
