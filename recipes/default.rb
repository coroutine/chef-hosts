#
# Cookbook Name:: hosts
# Recipe:: default
#
# Copyright 2012, Coroutine LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


# Given a list of chef nodes, write ip addresses and node 
# name aliases to /etc/hosts/. This info is read from:
# 
#   default[:host_aliases]

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
