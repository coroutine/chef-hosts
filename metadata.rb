maintainer       "bradmontgomery"
maintainer_email "bmontgomery@coroutine.com"
license          "super-secret"
description      "Writes host aliases"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.1"

recipe           "hosts", "Wites the /etc/hosts file based on attribute values"

%w{ ubuntu debian }.each do |os|
  supports os
end
