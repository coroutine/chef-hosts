#
# Cookbook Name:: hosts
# Recipe:: default
#
# Copyright 2012, Coroutine
#
# All rights reserved.
#
# Given a list of chef nodes, write ip addresses and node 
# name aliases to /etc/hosts/. This info is read from:
# 
#   default[:host_aliases]
#

# Include helper "internal_ip" to query internal IP addresses
::Chef::Recipe.send(:include, Opscode::HostAliases::Helpers)

host_entries = []

node[:host_aliases].each do |node_name|
  search(:node, "name:#{node_name}") do |node|
    ip = begin
      addr = internal_ip
      if addr.nil?
        node.ipaddress
      else
        addr 
      end
    end
    host_entries << "#{ip} #{node.name}".strip if not (ip.empty? || ip.nil?) and not node.name.empty?
  end
end

template "/etc/hosts" do
  source "hosts.erb"
  mode 0644
  variables(:host_entries => host_entries)
end
