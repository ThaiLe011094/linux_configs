#!/bin/bash

# Sample error for motivating writing this script
# error: error sending request for url (https://aur.archlinux.org/rpc): error trying to connect: unexpected EOF: error trying to connect: unexpected EOF: unexpected EOF

# Reference: https://bbs.archlinux.org/viewtopic.php?id=295962

# After running this scrip
# user can use `paru`
curl -v 'https://aur.archlinux.org/' >/dev/null
