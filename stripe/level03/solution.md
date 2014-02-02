# Stripe-CTF Level 03

## Overview

Examining the source, we see that the "run" function conveniently executes our string.  Unfortunately, it is not in the list of function pointers (i.e. addresses) specified by the variable "fns".  Ideally, we would add the address of run() to "fns" so that we could specify an index to it.  In lieu of that, however, we notice that the value of "index" is only restricted in the positive direction.  Since our stack grows towards lower memory addresses, this means that "buf" (declared in truncate_and_call()) has a lower memory address than "fns" (declared in main).  So, if we specify the right negative value for the index, we can read a value from "buf" as the function address.  Assuming this function address is that of run(), it will now be executed with our string as its argument.  By adding an actual command to our string after the address of run(), we can execute arbitrary code and create a shell.

## Execution

We use gdb to obtain the address for run(), the address for "fns", and the address for "buf".  The negative of the difference between the latter two will be our index value, and the address of run goes in our string.  We must also be mindful of our architecture, as word size and endianness become important considerations (see Notes below).

```
$> gdb ./level03
(gdb) break truncate_and_call
(gdb) next
(gdb) print fns
      <address>
(gdb) print &buf
      <address>
(gdb) info address run
      <address>

negative_offset = (buf_address - fns_address) / 4

$> ./level03 <negative_offset> <run_address>\;/bin/sh
root $>

## Notes

The difference between little-endian and big-architectures now becomes important.  In the case of the latter, if our address of run() is 0x1234, we must place 3412 into our string.

We divide the offset by 4 to account for the word size of our architecture.
