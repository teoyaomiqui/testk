# -*- mode: ruby -*-
# vi: set ft=ruby :
# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
require "yaml"

deployment_model = YAML.load_file('deployment_model.yaml')['deployment_model']

role_to_host_mapping = Hash.new

deployment_model["roles"].each do |role|
  hosts_list = Array.new
  deployment_model["hosts"].each do |host|
    if host["role"] == role
      role_to_host_mapping[role] = hosts_list.push(host["hostname"])
    end
  end
end

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

  deployment_model["hosts"].each do |host|
    role = host["role"]

    config.vm.define host["id"] do |node|

      node.vm.synced_folder "deployment/webserver/salt", "/srv/salt"
      node.vm.hostname = host["hostname"]
      node.vm.network :private_network,
      :ip => host["ip"],
      :libvirt__dhcp_enabled => false,
      :libvirt__forward_mode => "none"

      node.vm.provider :libvirt do |domain|
        domain.memory = host["ram"]
        domain.nested = true
      end


      node.vm.provision :salt do |salt|
        salt.masterless = true
	salt.run_highstate = true
	salt.install_type = "git"
	salt.install_args = "v2016.11.2"
        salt.bootstrap_options = "-p python-jenkins"
	salt.verbose = true
	salt.pillar({"hosts" => deployment_model["hosts"]})
	salt.pillar({"role" => role})
        salt.pillar(deployment_model[role])
        salt.pillar(role_to_host_mapping)
      end
    end
  end
end
