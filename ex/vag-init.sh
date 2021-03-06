#!/bin/bash

# Exit on error
set -e
set -x

vag_box=mrscotty/sles11-oxibuild
vag_provider=virtualbox

if [ ! -f Vagrantfile ]; then
    vagrant init $vag_box
fi

if [ ! -f .vagrant/machines/default/$vag_provider/id ]; then
    vagrant up
fi

if vagrant status default | egrep -q 'poweroff|aborted|not created'; then
    vagrant up
fi


