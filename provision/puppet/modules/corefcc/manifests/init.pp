class corefcc () inherits corefcc::ownership {

  # INFO: fcc staturday summit demo
  # INFO: everything will be done manually
  exec { 'limit_npm':
    command => 'npm config set jobs 1',
    path => ['/usr/bin', '/usr/local/bin'],
    user => 'vagrant',
    require => [Exec['install_node'], Class['corefcc::ownership']]
  }

  # INFO: get the FCC Repo from github
  exec { 'git_clone_fcc':
    command => 'git clone --depth=1 https://github.com/freecodecamp/freecodecamp.git development/freecodecamp',
    onlyif => ['test ! -e /home/vagrant/development/freecodecamp/package.json'],
    path => ['/bin', '/usr/bin'],
    cwd => '/home/vagrant',
    user => 'vagrant',
    group => 'root',
    require => [Package['git'], Package['curl']]
  }

  # # INFO: run npm install to get all dependencies
  # exec { 'npm_install':
  #   command => 'sudo npm install --loglevel silent',
  #   # onlyif => ['test ! -d /home/vagrant/development/freecodecamp/node_modules'],
  #   path => ['/usr/bin', '/usr/local/bin'],
  #   returns => [0, 254],
  #   cwd => '/home/vagrant/development/freecodecamp',
  #   user => 'vagrant',
  #   group => 'vagrant',
  #   timeout => 0,
  #   require => [Exec['install_node'], Exec['limit_npm'], Exec['git_clone_fcc'], Class['corefcc::ownership'], Exec['npm_install_babel_globally']]
  # }
  #
  # install babel globablly (needed for dependencies)
  exec { 'npm_install_babel_globally':
    command => 'npm install -g babel@5.8.29',
    path => ['/usr/local/bin', '/usr/bin', '/bin'],
    user => 'vagrant',
    timeout => 0,
    require => [Exec['install_node'], Class['corefcc::ownership'], Exec['limit_npm']]
  }
  # # install gulp globally
  # exec { 'npm_install_gulp_globally':
  #   command => 'npm install -g gulp',
  #   path => ['/usr/local/bin', '/usr/bin', '/bin'],
  #   # cwd => '/home/vagrant/development/freecodecamp',
  #   user => 'vagrant',
  #   timeout => 0,
  #   require => [Exec['install_node'], Class['corefcc::ownership'], Exec['limit_npm']]
  # }
  #
  # # install bower globally
  # exec { 'npm_install_bower_globally':
  #   command => 'npm install -g bower',
  #   path => ['/usr/local/bin', '/usr/bin', '/bin'],
  #   cwd => '/home/vagrant/development/freecodecamp',
  #   user => 'vagrant',
  #   timeout => 0,
  #   require => [Exec['install_node'], Class['corefcc::ownership'], Exec['limit_npm']]
  # }
  #
  # # run command `bower install`
  # exec { 'bower_install':
  #   command => 'bower install',
  #   path => ['/usr/local/bin', '/usr/bin', '/bin'],
  #   cwd => '/home/vagrant/development/freecodecamp',
  #   user => 'vagrant',
  #   timeout => 0,
  #   require => [Package['git'], Exec['git_clone_fcc'], Exec['install_node'], Exec['npm_install_bower_globally'], Class['corefcc::ownership'], Exec['limit_npm']]
  # }

  # create .env file for user to edit
  file { 'env-file':
    path => '/home/vagrant/development/freecodecamp/.env',
    ensure => present,
    group => 'root',
    owner => 'vagrant',
    source => 'puppet:///modules/corefcc/fcc-env-file',
    require => [Exec['git_clone_fcc']]
  }
}
