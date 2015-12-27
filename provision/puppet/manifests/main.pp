# class user_creation {
#   $pass = "password"
#   $salt = "somesalt"

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
    path => ["/bin", "/usr/bin"]
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

# List out provisioning stages
stage { 'pre': before => Stage['main'] }
stage { 'post': require => Stage['main'] }

# List classes in stages
class { 'apt_update':
  stage => pre
}
class { 'othertools':
  stage => pre
}
class { 'nodejs':
  stage => main
}
class { 'mongodb':
  stage => main
}
class { 'freecodecamp':
  stage => post
}

include apt_update
include othertools
include nodejs
include mongodb
include freecodecamp
#include user_creation