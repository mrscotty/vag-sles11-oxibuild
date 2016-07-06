#!/bin/bash

for i in myperl-openxpki-i18n myperl-openxpki-core myperl-openxpki-core-deps; do
    rpm -q $i && sudo rpm -e $i
done
