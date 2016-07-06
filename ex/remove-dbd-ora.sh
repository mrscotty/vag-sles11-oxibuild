#!/bin/bash

for i in myperl-dbd-oracle; do
    rpm -q $i && sudo rpm -e $i
done
