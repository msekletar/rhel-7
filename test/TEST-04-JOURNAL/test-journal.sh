#!/bin/bash

set -x
set -e
set -o pipefail

# Test stdout stream

# Skip empty lines
ID=$(journalctl --new-id128 | sed -n 2p)
>/expected
printf $'\n\n\n' | systemd-cat -t "$ID" --level-prefix false
journalctl --flush
journalctl -b -o cat -t "$ID" >/output
cmp /expected /output

touch /testok
exit 0
