#!/bin/bash
#
# build-openca-tools.sh - Build openca-tools for SLES 11 in Vagrant
#
# This script depends on a Vagrant SLES11 image with a few packages
# already installed, including myperl and myperl-buildtools.

# Exit on error
set -e

basedir=$(dirname $0)

. $basedir/settings.rc
. $basedir/settings-myperl.rc

GITDIR=~/git/openca-tools

# Directory where rpmbuild puts the new packages
rpmsdir=~/rpmbuild/RPMS/x86_64

# Directory where we consolidate the new packages
test -d /vagrant/rpms || mkdir -p /vagrant/rpms

# Clone and update openxpki repo, if needed.
# Note: the 'git pull' uses fast-forward only to abort if there are local
# modifications. 
test -d $GITDIR || git clone $OPENCATOOLS_GITURL $GITDIR
(cd $GITDIR && git remote update && git checkout $OPENCATOOLS_BRANCH && git pull --ff-only)

(cd $GITDIR && ./configure && make dist && make rpm)

mv $GITDIR/openca-tools*.rpm /vagrant/rpms/


