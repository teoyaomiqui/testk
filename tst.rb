#!/usr/bin/env ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :
# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
require  'bcrypt'
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

jenkins_password = deployment_model["monitor"]["jenkins"]["password"]
hashed_password = BCrypt::Password.create jenkins_password
jenkins_hash = {"password_hash" => hashed_password, "password" => jenkins_password, "user" => "admin", "url" => "http://localhost:8080"}

puts jenkins_hash
puts jenkins_password
puts deployment_model
