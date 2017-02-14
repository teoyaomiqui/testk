Basic Apache2 webstack
======================
Vagrant deployment of 2 apache2 webservers behind loadbalancer and jenkins as server monitor(POC):

## Topics

- [Deployment technological stack](#deployment-technological-stack)
- [Host machine requirements](#host-machine-requirements)
- [Deployment topology overview](#deployment-topology-overview)
- [Deployment instructions](#deployment-instructions)
- [Limitations](#limitations)
- [External links and documentation](#external-links-and-documentation)

## Deployment technological stack
This basic deployment is provided to demonstrate potential for the following technological stack:
- Ubuntu 16.04 xenial linux distribution
- Vagrant
- Saltstack as Vagrant provisioner
- Libvirt with KVM driver and Vagrant virtualization provider

## Host machine requirements:
- Ubuntu 16.04 Xenial host machine with 4G of RAM
- Vagrant version 1.8.7 (patch has to be applied to fix the [reported bug](https://github.com/mitchellh/vagrant/issues/8005):
- KVM + Libvirt stack installed
- Vagrant libvirt-plugin version 0.0.35
- Internet access

## Deployment topology overview
- All nodes connected with private isolated network without forwarding and DHCP
- 2 apache2 webservers, on standalone virtualized hosts, behind single loadbalancer
- Haproxy reverse proxy, on standalone virtualized host, balancing webservers with roundrobin balancing strategy
- Jenkins java application as monitor, on standalone virtualized host, with a job configured to check webservers via Haproxy every hour during nights (build fails if 2nd webserver is served, succeeds if 1st webserver is served)
- Vagrant is used on host machine to virtualize nodes
- Saltstack is used as Vagrant provisioner

## Deployment instructions:
- Clone this repo:
```bash

git clone https://github.com/teoyaomiqui/testk
```
- Carefuly edit deployment_model.yaml file to adjust deployment to match your needs, read comments to understand how they can impact the deployment
```bash

vim deployment_model.yaml
```
- Run prepare_env.sh script to prepare Vagrant environment with sudo privileges, script installs Libvirt and KVM stack and patch Vagrant to fix [vagrant issue](Deployment instructions):
```bash

./prepare_env.sh
```
- Use vagrant to deploy virtual machines:
```bash

vagrant up --provider libvirt
```

## Limitations:
- This is environment infrastructure is limited to be used only on Ubuntu 16.04 LTS Xenial host machine
- Vagrant box used was [yk0/ubuntu-xenial](https://atlas.hashicorp.com/yk0/boxes/ubuntu-xenial)
- Versions specified in requirements are must, and chosen to be most stable of what currently is available
- If prepare_env.sh script isn't used, be sure to fix [reported bug](https://github.com/mitchellh/vagrant/issues/8005)

## External links and documentation
- [Vagrant project](https://www.vagrantup.com/)
- [Vagrant documetation](https://www.vagrantup.com/docs/)
- [Saltstack as Vagrant provisioner documentation](https://www.vagrantup.com/docs/provisioning/salt.html)
- [Vagrant-libvirt plugin source code](https://github.com/vagrant-libvirt/vagrant-libvirt)
- [Vagrant-libvirt plugin documentations](https://github.com/vagrant-libvirt/vagrant-libvirt/blob/master/README.md)
- [Saltstack project](https://saltstack.com/)
- [Saltstack documentation](https://docs.saltstack.com/en/latest/)
- [Libvirt project](https://libvirt.org/)
- [Libvirt documentation](https://libvirt.org/docs.html)
