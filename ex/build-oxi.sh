#!/bin/bash
#
# build-oxi.sh - Build OpenXPKI packages for SLES 11 in Vagrant
#
# This script depends on a Vagrant SLES11 image with a few packages
# already installed, including myperl and myperl-buildtools.

# Exit on error
set -e

basedir=$(dirname $0)

. $basedir/settings.rc
. $basedir/settings-myperl.rc

# Directory where rpmbuild puts the new packages
rpmsdir=~/rpmbuild/RPMS/x86_64

# Directory where we consolidate the new packages
test -d /vagrant/rpms || mkdir -p /vagrant/rpms

# Clone and update openxpki repo, if needed.
# Note: the 'git pull' uses fast-forward only to abort if there are local
# modifications. 
test -d ~/git/openxpki || git clone $OPENXPKI_GITURL ~/git/openxpki
(cd ~/git/openxpki && git checkout $OPENXPKI_BRANCH && git pull --ff-only)


OXI_VERSION=$(cd ~/git/openxpki && perl tools/vergen --format version)
if [ -z "$OXI_VERSION" ]; then
    echo "ERROR - failed to detect OpenXPKI version" 1>&2
    exit 1
fi

# 
# OpenXPKI Core Dependencies
#
if ! rpm -q myperl-openxpki-core-deps >/dev/null 2>&1; then
    (cd ~/git/openxpki/package/suse/myperl-openxpki-core-deps && \
        PERL_MM_OPT='INC="$OPENSSL_INC"' PERL5LIB=$HOME/perl5/lib/perl5/ make \
        DEBUG=$DEBUG )
    test $? == 0 || die "Error building myperl-openxpki-core-deps"
    sudo rpm -ivh \
        $rpmsdir/myperl-openxpki-core-deps-$OXI_VERSION-1.x86_64.rpm
    cp -av \
        $rpmsdir/myperl-openxpki-core-deps-$OXI_VERSION-1.x86_64.rpm \
        /vagrant/rpms/
fi

#
# OpenXPKI Core
#
if ! rpm -q myperl-openxpki-core >/dev/null 2>&1; then
    (cd ~/git/openxpki/package/suse/myperl-openxpki-core && \
        PERL_MM_OPT='INC="$OPENSSL_INC"' PERL5LIB=$HOME/perl5/lib/perl5/ make \
        DEBUG=$DEBUG )
    test $? == 0 || die "Error building myperl-openxpki-core"
    sudo rpm -ivh $rpmsdir/myperl-openxpki-core-$OXI_VERSION-1.x86_64.rpm
    cp -av \
        $rpmsdir/myperl-openxpki-core-$OXI_VERSION-1.x86_64.rpm \
        /vagrant/rpms/myperl-openxpki-core-$OXI_VERSION-1.x86_64.rpm 
fi

#
# OpenXPKI I18N
#
if ! rpm -q myperl-openxpki-i18n >/dev/null 2>&1; then
    (cd ~/git/openxpki/package/suse/myperl-openxpki-i18n && \
        PERL5LIB=$HOME/perl5/lib/perl5/ make \
        DEBUG=$DEBUG )
    test $? == 0 || die "Error building myperl-openxpki-i18n"
    sudo rpm -ivh $rpmsdir/myperl-openxpki-i18n-$OXI_VERSION-1.x86_64.rpm
    cp -av \
        $rpmsdir/myperl-openxpki-i18n-$OXI_VERSION-1.x86_64.rpm \
        /vagrant/rpms
fi

