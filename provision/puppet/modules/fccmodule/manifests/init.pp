class fccmodule(
  $node_version = undef,
  $home_dir     = undef,
  $default_bin  = undef,
  $nvm_path     = undef,
  $default_user = undef
) {
  $version  = pick($node_version, '4.2.2')
  $dir      = pick($home_dir, '/home/vagrant')
  $bin      = pick($default_bin, '/usr/local/bin:/usr/bin:/bin')
  $npm_path = pick($nvm_path, [
    "/usr/local/bin",
    "/usr/bin",
    "/bin",
    "${dir}/.nvm/versions/node/v${version}/bin"
  ])
  $user     = pick($default_user, 'vagrant')

  exec { 'clone_fcc':
    user    => $user,
    command => "git clone --depth=1 https://github.com/freecodecamp/freecodecamp.git freecodecamp",
    path    => $bin,
    cwd     => $dir,
    unless  => ["test -f ${dir}/freecodecamp/package.json"],
    require => [Package["git"]]
  }

  exec { 'limit_npm':
    user    => $user,
    command => "bash -c 'source ${dir}/.bashrc ; npm config set jobs 1'",
    path    => $npm_path,
    logoutput => on_failure,
    require => [Class['nodejs']]
  }

  file { 'fcc-env-file':
    path    => "${dir}/freecodecamp/.env",
    ensure  => present,
    group   => 'root',
    owner   => $user,
    source  => 'puppet:///modules/fccmodule/fcc-env-file',
    require => [Exec['clone_fcc']]
  }

  exec { 'npm_install_babel_globally':
    user    => $user,
    command => "bash -c 'source ${dir}/.bashrc ; npm install -g babel@5.8.29'",
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