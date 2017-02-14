Basic Apache2 webstack
======================
Vagrant deployment of 2 apache2 webservers behind loadbalancer and jenkins as server monitor(POC):

## Topics

- [Deployment technological stack](#deployment-technological-stack)
- [Host machine requirements](#host-machine-requirements)
- [Deployment topology overview](#deployment-topology-overview)
- [Deployment instructions](#deployment-instructions)
- [Time](#time)
- [Post-Processing](#post-processing)
- [Ray Tracing & Distance Functions](#ray-tracing--distance-functions)
- [Text, Lines & Shapes](#text-lines--shapes)
- [Non-Photorealistic Rendering](#non-photorealistic-rendering)
- [Math](#math)
- [Misc Optimizations](#misc-optimizations)
- [Collections](#collections)
- [Bloggers](#bloggers)
- [Tools](#tools)
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
-  Run prepare_env.sh script to prepare Vagrant environment with sudo privileges, script installs Libvirt and KVM stack and patch Vagrant to fix [vagrant issue](Deployment instructions):
```bash

./prepare_env.sh
```
- Use vagrant to deploy virtual machines:
```bash
vagrant up –provider libvirt
```





