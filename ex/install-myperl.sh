#!/bin/bash

# TODO: add checking for multiple RPM files of the same package

rpms=$(ls /vagrant/rpms/myperl-*.rpm | grep -v openxpki)
echo "Installing $rpms..."
sudo rpm -Uvh $rpms
