#!/bin/bash

# Lists all IPs in the given network prefix
# /24 CIDR only

# Usage: bash IPList.bash 10.0.17
[ $# -ne 1 ] && echo "Usage: $0 <Prefix>" && exit 1

# Prefix is the first input taken
prefix=$1

# Verify input length
[ ${#prefix} -lt 5 ] && \
printf "Prefix length is too short\n Prefix ex: 10.0.17\n" && \
exit 1

for i in {1..254}
do
    echo "$prefix.$i"
done

