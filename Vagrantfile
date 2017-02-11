# -*- mode: ruby -*-
# vi: set ft=ruby :
# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
require 'yaml'
#current_dir    = File.dirname(File.expand_path(__FILE__))
#configs        = YAML.load_file("#{current_dir}/config.yaml")
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.
  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "yk0/ubuntu-xenial"
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false
  config.vm.provider :libvirt do |domain|
    domain.memory = 4096
    domain.nested = true
  end
  config.vm.define :jenkins do |jenkins|
    jenkins.vm.hostname = "jenkins"
    jenkins.vm.network :private_network, 
    :ip => "10.20.30.40",
    :libvirt__dhcp_enabled => false,
    :libvirt__forward_mode => 'none'
    jenkins.vm.provision :hosts, :sync_hosts => true

  end
  # Guest 2
  config.vm.define :haproxy do |haproxy|
    haproxy.vm.hostname = "haproxy"
    haproxy.vm.network :private_network,
    :ip => "10.20.30.41",
    :libvirt__dhcp_enabled => false,
    :libvirt__forward_mode => 'none'
    haproxy.vm.provision :hosts, :sync_hosts => true
  end
  (1..3).each do |i|
    config.vm.define :"node-#{i}" do |node|
      node.vm.hostname = "node-1"
      node.vm.network :private_network,
      :ip => "10.20.30.5#{i}",
      :libvirt__dhcp_enabled => false,
      :libvirt__forward_mode => 'none'
      node.vm.provision :hosts, :sync_hosts => true
    end
  end
end
