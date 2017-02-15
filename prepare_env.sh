#!/bin/bash
#TODO: Refactore this scrpit to be less hardcoded
set -e

VAGRANTFILETOPATCH="/opt/vagrant/embedded/gems/gems/vagrant-1.8.7/plugins/provisioners/salt/provisioner.rb"

export DEBIAN_FRONTEND=noninteractive
wget https://releases.hashicorp.com/vagrant/1.8.7/vagrant_1.8.7_x86_64.deb -O /tmp/vagrant_1.8.7_x86_64.deb
dpkg -i /tmp/vagrant_1.8.7_x86_64.deb

apt-get update -q
apt-get install -q -f -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" qemu-kvm libvirt-bin libvirt-dev bridge-utils
adduser $USER libvirtd

apt-get install -q -f -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" vagrant
vagrant plugin install vagrant-libvirt --plugin-version=0.0.35

patch $VAGRANTFILETOPATCH < patches/patch

echo "Enviroment is prepared"

