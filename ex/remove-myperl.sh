#!/bin/bash

for i in myperl-dbd-mysql myperl-fcgi myperl-dbi myperl-buildtools myperl; do
    rpm -q $i && sudo rpm -e $i
done
