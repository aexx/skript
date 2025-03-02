#!/bin/bash

set -eu
snap list --all |
awk '/deaktiviert/{print $1, $3}' |
while read name rev
do
snap remove "$name" \
--revision="$rev"
done
