#
# Cookbook Name:: hosts
# Copyright 2012, Coroutine
#
# All rights reserved.
#

# Find an *internal* IP Address (if any)
module Opscode
  module HostAliases
    module Helpers

      # Inspects the node to find all the assigned ip addresses 
      def interface_addresses
        ip_addresses = [] 
        if node.has_key?("network") and node["network"].has_key?("interfaces")
          node["network"]["interfaces"].each do |iface|
            # iface is [<name>, {"addresses"=>{}, ... }]
            ip_addresses.concat begin
              ip_addresses.concat iface[1]["addresses"].keys
            rescue 
              []
            end
          end
        end
        Chef::Log.info "IP Addesses assigned to this host: #{ip_addresses.join ', '}"
        ip_addresses
      end

      # Returns the first ip address that starts with 192 or 10 or nil
      def find_private_ip
        ip_addresses = interface_addresses
        ip_addresses.each do |ip|
          if ip.start_with?("192") || ip.start_with?("10")
            return ip
          end
        end
        return nil
      end

      def internal_ip
        private_ip = find_private_ip

        internal_ip = begin
          if node.attribute?("cloud") && node.cloud.attribue?("local_ipv4")
            Chef::Log.info "node.cloud.local_ipv4: #{node.cloud.local_ipv4}"
            node.cloud.local_ipv4
            Chef::Log.info "Using Cloud IP: #{node.cloud.local_ipv4}"
          elsif private_ip
            Chef::Log.info "Using Private IP: #{private_ip}"
            private_ip
          else
            # Anything else would yield a public IP, e.g.
            #   node.cloud.public_ipv4
            #   node.ipaddress
            # Therefore, just return nil and handle this case elsewhere.
            nil
          end
        end
      end

    end
  end
end
