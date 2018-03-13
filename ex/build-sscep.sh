#!/bin/bash
#
# build-sscep.sh - Build sscep for SLES 11 in Vagrant
#
# This script depends on a Vagrant SLES11 image with a few packages
# already installed, including myperl and myperl-buildtools.

# Exit on error
set -e

basedir=$(dirname $0)

. $basedir/settings.rc
. $basedir/settings-myperl.rc

GITDIR=~/git/sscep
GITURL=${SSCEP_GITURL:=https://github.com/certnanny/sscep.git}
GITBRANCH=${SSCEP_BRANCH:=master}

# Directory where rpmbuild puts the new packages
rpmsdir=~/rpmbuild/RPMS/x86_64

# Directory where we consolidate the new packages
test -d /vagrant/rpms || mkdir -p /vagrant/rpms

# Clone and update openxpki repo, if needed.
# Note: the 'git pull' uses fast-forward only to abort if there are local
# modifications. 
test -d $GITDIR || git clone $GITURL $GITDIR
(cd $GITDIR && git remote update && git checkout $GITBRANCH && git pull --ff-only)

(cd $GITDIR/Linux && make package)

mv $rpmsdir/sscep*.rpm /vagrant/rpms/


