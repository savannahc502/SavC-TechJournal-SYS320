ip addr | grep "brd" | awk '/inet / {print $2}' | cut -d/ -f1
