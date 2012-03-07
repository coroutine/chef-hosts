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

Copyright 2012,  Coroutine LLC.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
