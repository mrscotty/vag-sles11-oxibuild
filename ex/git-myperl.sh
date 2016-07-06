#!/bin/bash

# Exit on error
set -e

basedir=$(dirname $0)

if [ -z "$MYPERL_GITURL" ]; then
    . $basedir/settings.rc
fi

test -d ~/git/myperl || git clone $MYPERL_GITURL ~/git/myperl
(cd ~/git/myperl && git checkout $MYPERL_BRANCH && git pull --ff-only)

