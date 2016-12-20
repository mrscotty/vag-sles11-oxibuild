# vag-sles11-oxibuild

Vagrant instance for building myperl and openxpki RPMs with SLES SP3

# Getting Started

To run the scripts, you'll need a special vagrant box that contains
SLES 11 and a couple of RPMS and other modifications needed for
the build process.

To fetch the latest box from HashiCorp, run:

    vagrant box add mrscotty/sles11-oxibuild

To fetch a specific box from packages.openxpki.org:

    vagrant box add mrscotty/sles11sp4-oxibuild \
        http://packages.openxpki.org/vagrant/mrscotty-sles11-oxibuild.box

Running the 'make <target>' will initialize the Vagrant instance for you. 
If you want to edit the Vagrantfile before starting (e.g. to add a shared
folder for your local code repo), run the following:

    vagrant init mrscotty/sles11-oxibuild

# Local Customization

The configuration settings are located in the ex/settings\*.sh files.

To override these settings, create the file local.rc in the root directory of
the repository. As an example:

    # Clone local working repo via the Vagrant filesystem sharing.
    # Note: In this example, the "/code-repo" path must be configured
    # for sharing in the Vagrantfile.
    OPENXPKI_GITURL=/code-repo
    # Override branch name with a current working branch
    OPENXPKI_BRANCH=develop

    # Set the name of the packager for the RPM specfile (note: this
    # environment variable needs to be "exported")
    PACKAGER="Scott Hardin"
    export PACKAGER

    # Specify CPAN mirror
    export CPANM_MIRROR=/vagrant/cpan
    
# Building RPMS

## myperl

    make myperl

## myperl-openxpki-\*

    make oxi

## myperl-dbd-oracle

    make ora

# Re-install existing myperl packages on new guest instance

    make inst-myperl

# Re-Building RPMS

To re-build RPM packages, the existing packages in the running Vagrant
instance must be uninstalled. This can be done with the following commands:

    make rm-oxi
    make rm-myperl

# Re-cloning the Git repository

To remove the ~/git/openxpki working repository from the guest can be done
with the following (running 'make oxi' will download the latest clone):

    make rm-oxi-git

# CPAN Mirror

## Creating CPAN mirror

    minicpan -C minicpan.rc 
