class corefcc::ownership {
  # /usr/local/bin -> vagrant:root
  # /usr/local/lib/node_modules -> vagrant:root
  file { '/usr/local/bin':
    path => '/usr/local/bin',
    ensure => 'directory',
    group => 'root',
    owner => 'vagrant',
    require => [Exec['install_node']]
  }

  file { '/usr/local/lib/node_modules':
    path => '/usr/local/lib/node_modules',
    ensure => 'directory',
    group => 'root',
    owner => 'vagrant',
    require => [Exec['install_node']]
  }

  file { '/home/root':
    path => '/home/root',
    ensure => 'directory',
    group => 'root',
    owner => 'vagrant'
  }
}
