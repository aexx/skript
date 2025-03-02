#!/bin/bash

set -eu
sudo snap list --all |
awk '/deaktiviert/{print $1, $3}' |
while read name rev
do
sudo snap remove "$name" \
--revision="$rev"
done
