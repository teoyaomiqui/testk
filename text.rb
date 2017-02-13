#!/usr/bin/env ruby
require 'yaml'                                                                                           
                                                                                                         
deployment_model = YAML.load_file('deployment_model.yaml')['deployment_model']                           
                                                                                                         
role_to_host_mapping = Hash.new                                                                         

deployment_model["roles"].each do |role|
  hosts = Array.new
  deployment_model["hosts"].each do |host|
    if host["role"] == role
      role_to_host_mapping[role] = hosts.push(host["hostname"])
    end
  end
end 
puts role_to_host_mapping

##deployment_model['hosts'].each do |host|                                                                 
##  deployment_model['roles'].each do |role|                                                               
##    host["role"].include? role                                                                        
##      role_to_hosts_mapping[role] = hosts.push(host["id"])                                                     
##    end                                                                                                  
##  end                                                                                                    
##end      
##
##
##puts role_to_hosts_mapping
