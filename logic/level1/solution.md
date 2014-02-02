# Logic Level 1

## Overview

The web form allows us to upload a file.  It also preserves the name of the file, and allows us to navigate to its location.  Since the location of the stored files is parsed and served by the web server, any PHP files we upload will be parsed and executed.  By uploading a PHP file that reads a string from a GET variable, executes it on the system, and prints the output, we essentially obtain an interactive shell on the server.  Once there, we can poke around until we find what we are looking for.

## Execution

Upload the exploit file.
Navigate to \<url>\<exploit_file>?cmd=\<cmd>.
The password can be found in .bash_history.
