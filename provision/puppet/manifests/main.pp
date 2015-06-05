class user_creation {
  user { "fccuser":
    name => 'fccuser', # redundant
    ensure => 'present',
    # uid => '',
    # gid => '',
    shell => '/bin/bash',
    home => '/home/fccuser',
    comment => 'safe user',
    password => '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', # 'password'
    managehome => true,
    gid => 'vagrant',
    groups => 'sudo',
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
    command => "n stable",
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

include user_creation
include apt_update
include othertools
include nodejs
include mongodb