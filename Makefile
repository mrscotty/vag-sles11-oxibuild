# Makefile
#
# This makefile is just a "helper" for running the various 
# scripts either in the current shell or in the vagrant
# instance, as needed.
#

.PHONY: all myperl ora oxi rm-myperl

all: oxi

myperl:
	ex/vag-init.sh
	vagrant ssh --command /vagrant/ex/build-myperl.sh

ora:
	ex/vag-init.sh
	vagrant ssh --command /vagrant/ex/build-dbd-ora.sh

oxi:
	ex/vag-init.sh
	vagrant ssh --command /vagrant/ex/build-oxi.sh

rm-myperl:
	ex/vag-init.sh
	vagrant ssh --command /vagrant/ex/remove-myperl.sh

rm-oxi:
	ex/vag-init.sh
	vagrant ssh --command /vagrant/ex/remove-oxi.sh


