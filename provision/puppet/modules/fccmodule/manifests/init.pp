class fccmodule {
  $dir = '/home/vagrant'
  $bin = '/usr/local/bin:/usr/bin:/bin'
  $npm_path = '/usr/local/bin:/usr/bin:/bin:/home/vagrant/.nvm/versions/node/v4.2.2/bin'
  $user = 'vagrant'

  exec { 'clone_fcc':
    user    => $user,
    command => "git clone --depth=1 https://github.com/freecodecamp/freecodecamp.git freecodecamp",
    path    => $bin,
    cwd     => $dir,
    unless  => ['test -f /home/vagrant/freecodecamp/package.json'],
    require => [Package["git"]]
  }

  exec { 'limit_npm':
    user    => $user,
    command => "bash -c 'source /home/vagrant/.bashrc ; npm config set jobs 1'",
    path    => $npm_path,
    logoutput => on_failure,
    require => [Class['nodejs']]
  }

  file { 'fcc-env-file':
    path    => '/home/vagrant/freecodecamp/.env',
    ensure  => present,
    group   => 'root',
    owner   => $user,
    source  => 'puppet:///modules/freecodecamp/fcc-env-file',
    require => [Exec['clone_fcc']]
  }

  exec { 'npm_install_babel_globally':
    user    => $user,
    command => "bash -c 'source /home/vagrant/.bashrc ; npm install -g babel@5.8.29'",
    path    => $npm_path,
    timeout => 0,
    require => [Class['nodejs'], Exec['limit_npm']]
  }

  # EXPERIMENTAL
  # exec { 'npm_install_bower':
  #   command => "npm install -g bower",
  #   path => ["/bin", "/usr/bin", "/usr/local/bin"],
  #   cwd => "/home/vagrant/developer/freecodecamp",
  #   user => 'root',
  #   require => [Exec["clone_fcc"]]
  # }

  # exec { 'npm_install_fcc':
  #   command => "npm --logevel=error install",
  #   path => ["/bin", "/usr/bin", "/usr/local/bin"],
  #   cwd => "/home/vagrant/developer/freecodecamp",
  #   user => 'root',
  #   require => [Exec["npm_install_bower"]]
  # }

  # exec { 'bower_install':
  #   command => "bower install --config.interactive=false",
  #   path => ["/bin", "/usr/bin", "/usr/local/bin"],
  #   cwd => "/home/vagrant/developer/freecodecamp",
  #   user => 'root',
  #   require => [Exec["npm_install_fcc"]]
  # }
}