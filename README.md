Description
===========
This cookbook defines a recipe that writes host aliases (an `/etc/hosts` file) 
based on nodes listed in an attribute.

Usage
=====
Define a list of node names in the `node[:host_aliases]` attribute. For example, 
you might add something like the following in a role:
    
    name "role_with_host_aliases"
    descript "this is a sample role"
    run_list "recipe[hosts]"

    override_attributes(
      "host_aliases" => ["node01", "node02"]
    )

License and Author
==================

Author:: Brad Montgomery <bmontgomery@coroutine.com>

Copyright 2012, Coroutine

All rights reserved.
