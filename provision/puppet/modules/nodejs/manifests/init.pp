class nodejs {
  exec { "git_clone_n":
    command => "git clone https://github.com/visionmedia/n.git /home/vagrant/n",
    path => ["/bin", "/usr/bin"],
    onlyif => ['test ! -d /home/vagrant/n'],
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
