#!/bin/bash

# TODO: add checking for multiple RPM files of the same package

# Note: the strange wildcard string is needed because "myperl-*.x86_64.rpm"
# would be too greedy
sudo rpm -ivh \
    /vagrant/rpms/myperl-[0-9]*.x86_64.rpm \
    /vagrant/rpms/myperl-buildtools-*.x86_64.rpm \
    /vagrant/rpms/myperl-dbi-*.x86_64.rpm \
    /vagrant/rpms/myperl-fcgi-*.x86_64.rpm \
    /vagrant/rpms/myperl-dbd-mysql-*.x86_64.rpm

