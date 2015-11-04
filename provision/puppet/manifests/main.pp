class user_creation {
  $pass = "password"
  $salt = "somesalt"

  user { "fccuser":
    name => 'fccuser', # redundant
    ensure => 'present',
    # uid => '', # auto generated
    shell => '/bin/bash',
    home => '/home/fccuser',
    comment => 'safe user',
    password => inline_template("<%= '$pass'.crypt('\$6$$salt') %>"),
    managehome => true,
    gid => 'vagrant',
    groups => [],
  }
}

class fcc {
  exec { 'git_clone_fcc':
    command => 'git clone --depth=1 https://github.com/freecodecamp/freecodecamp.git development/freecodecamp',
    path => ['/bin', '/usr/bin'],
    cwd => '/home/vagrant',
    require => [Package['git'], Package['curl'], Exec['install_node']]
  }

  exec { 'npm_install':
    command => 'sudo npm install',
    path => ['/usr/local/bin'],
    cwd => '/home/vagrant/development/freecodecamp',
    require => [Exec['git_clone_fcc']]
  }
}

class apt_update {
  exec { "aptGetUpdate":
    command => "sudo apt-get update",
    path => ["/bin", "/usr/bin"]
  }
}

class nodejs {
  exec { "git_clone_n":
    command => "git clone https://github.com/visionmedia/n.git /home/vagrant/n",
    path => ["/bin", "/usr/bin"],
    require => [Exec["aptGetUpdate"], Package["git"], Package["curl"], Package["g++"]]
  }

  exec { "install_n":
    command => "make install",
    path => ["/bin", "/usr/bin"],
    cwd => "/home/vagrant/n",
    require => Exec["git_clone_n"]
  }

  exec { "install_node":
    command => "n 4.2.1",
    path => ["/bin", "/usr/bin", "/usr/local/bin"],
    require => [Exec["git_clone_n"], Exec["install_n"]]
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
include fcc
