# class user_creation {
#   $pass = "password"
#   $salt = "somesalt"
#
#   user { "fccuser":
#     name => 'fccuser', # redundant
#     ensure => 'present',
#     # uid => '', # auto generated
#     shell => '/bin/bash',
#     home => '/home/fccuser',
#     comment => 'safe user',
#     password => inline_template("<%= '$pass'.crypt('\$6$$salt') %>"),
#     managehome => true,
#     gid => 'vagrant',
#     groups => [],
#   }
# }

class apt_update {
  exec { "aptGetUpdate":
    command => "sudo apt-get update",
    path => ["/bin", "/usr/bin"],
    timeout => 0
  }
}

class mongodb {
  class {'::mongodb::globals':
    manage_package_repo => true,
    bind_ip             => ["127.0.0.1"],
  }->
  class {'::mongodb::server':
    port    => 27017,
    verbose => true,
    ensure  => "present"
  }->
  class {'::mongodb::client': }
}


#include user_creation
include apt_update
include othertools
include nodejs
include mongodb
include corefcc
