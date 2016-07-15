# Makefile
#
# This makefile is just a "helper" for running the various 
# scripts either in the current shell or in the vagrant
# instance, as needed.
#

.PHONY: all init myperl ora oxi rm-myperl rm-oxi inst-myperl

all: oxi

init:
	ex/vag-init.sh

myperl: init
	vagrant ssh --command /vagrant/ex/build-myperl.sh

ora: init
	vagrant ssh --command /vagrant/ex/build-dbd-ora.sh

oxi: init
	vagrant ssh --command /vagrant/ex/build-oxi.sh

############################################################
# Remove currently-installed packages (e.g. to rebuild them)
############################################################
rm-myperl: init
	vagrant ssh --command /vagrant/ex/remove-myperl.sh

rm-oxi: init
	vagrant ssh --command /vagrant/ex/remove-oxi.sh

############################################################
# Install previously-built packages (e.g. to build just oxi)
############################################################

inst-myperl: init
	vagrant ssh --command /vagrant/ex/install-myperl.sh

