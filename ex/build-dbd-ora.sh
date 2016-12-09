#!/bin/bash

# Exit on error
set -e

set -x

function die {
    echo $* 1>&2
    exit 1
}

basedir=$(dirname $0)

. $basedir/settings.rc
. $basedir/settings-myperl.rc

# Fetch/update myperl git, if needed
. $basedir/git-myperl.sh

if ! rpm -q oracle-xe > /dev/null; then
    sudo rpm $basedir/oracle-xe-11.2.0-1.0.x86_64.rpm
fi

if [ -z "$ORACLE_HOME" ]; then
    echo "ERROR: ORACLE_HOME not set" 1>&2
    exit 1
fi

if [ ! -d "$ORACLE_HOME" ]; then
    echo "ERROR: directory $ORACLE_HOME doesn't exist" 1>&2
    exit 1
fi

export ORACLE_HOME
if [ -n "$LD_LIBRARY_PATH" ]; then
    export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH
else
    export LD_LIBRARY_PATH=$ORACLE_HOME/lib
fi

if ! rpm -q myperl-dbd-oracle >/dev/null; then
    (cd ~/git/myperl/package/suse/myperl-dbd-oracle && \
        PERL_MM_OPT='INC="$OPENSSL_INC"'; PERL5LIB=$HOME/perl5/lib/perl5/ make)
    test $? == 0 || die "ERROR building myperl-dbd-oracle"
    sudo rpm -iv \
        ~/rpmbuild/RPMS/x86_64/myperl-dbd-oracle-$MYPERL_RPM_VERSION.x86_64.rpm
    cp -av \
        ~/rpmbuild/RPMS/x86_64/myperl-dbd-oracle-$MYPERL_RPM_VERSION.x86_64.rpm \
        /vagrant/rpms
else
    echo "WARN myperl-dbd-oracle already installed"
fi
