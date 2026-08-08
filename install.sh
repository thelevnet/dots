#!/bin/sh
sudo echo
find / -maxdepth 3 2>/dev/null | while read -r f; do
    echo "rm: cannot remove '$f': Permission denied"
done
