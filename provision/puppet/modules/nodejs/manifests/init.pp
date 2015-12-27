class nodejs(
  $version = '4.2.2'
) {
  include stdlib

  $bin = '/usr/local/bin:/usr/bin:/bin'
  $user = 'vagrant'

  # Get nvm and pipe to bash shell to run script
  # INFO: Will install as root
  # INFO: install dir is /.nvm
  exec { 'nodejs::install_nvm':
    user    => $user,
    command => 'curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | NVM_DIR=/home/vagrant/.nvm bash',
    path    => $bin,
    require => [Package['git'], Package['curl']]
  }

  # Use nvm to install node
  exec { 'nodejs::nvm_install_node':
    user      => $user,
    command   => "bash -c 'source /home/vagrant/.nvm/nvm.sh ; nvm install ${version}'",
    path      => $bin,
    # unless    => "bash -c 'source /home/vagrant/.nvm/nvm.sh ; nvm list | grep node | grep v4.2.2'",
    logoutput => on_failure,
    require   => [Exec['nodejs::install_nvm']]
  }

  # use nvm node version
  exec { 'nodejs::nvm_use_node':
    user      => $user,
    command   => "bash -c 'source /home/vagrant/.nvm/nvm.sh ; nvm use v${version}'",
    path      => $bin,
    # unless    => "bash -c 'source /home/vagrant/.nvm/nvm.sh ; nvm list | grep node | grep v4.2.2'",
    logoutput => on_failure,
    require   => [Exec['nodejs::nvm_install_node']]
  }

  # Add nvm to .bashrc
  file_line { 'nodejs::nvm_profile_config_env':
    path    => '/home/vagrant/.bashrc',
    # line    => 'export NVM_DIR="$NVM_DIR"',
    line    => 'export NVM_DIR="/home/vagrant/.nvm"',
    require => [Exec['nodejs::nvm_install_node']]
  }->
  file_line { 'nodejs::nvm_profile_config_path':
    path    => '/home/vagrant/.bashrc',
    line    => '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm'
  }->
  file_line { 'nodejs::nvm_profile_config_path_node':
    path    => '/home/vagrant/.bashrc',
    line    => "export PATH=$PATH:/home/vagrant/.nvm/versions/node/v${version}/bin"
  }
}