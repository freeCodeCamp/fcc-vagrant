class othertools {
  package { "git":
    ensure => latest,
    require => Exec["aptGetUpdate"]
  }

  package { "m4":
    ensure => present,
    require => Exec["aptGetUpdate"]
  }

  package { "ruby":
    ensure => latest,
    require => Exec["aptGetUpdate"]
  }

  package { "vim-common":
    ensure => latest,
    require => Exec["aptGetUpdate"]
  }

  package { "curl":
  ensure => present,
  require => Exec["aptGetUpdate"]
  }

  package { "htop":
    ensure => present,
    require => Exec["aptGetUpdate"]
  }

  package { "g++":
    ensure => present,
    require => Exec["aptGetUpdate"]
  }

  package { "build-essential": 
    ensure => present,
    require => Exec["aptGetUpdate"]
  }

  package { "texinfo":
    ensure => present,
    require => Exec["aptGetUpdate"]
  }

  package { "libbz2-dev":
    ensure => present,
    require => Exec["aptGetUpdate"]
  }

  package { "libcurl4-openssl-dev":
    ensure => present,
    require => Exec["aptGetUpdate"]
  }
  
  package { "libexpat-dev":
    ensure => present,
    require => Exec["aptGetUpdate"]
  }

  package { "libncurses-dev":
    ensure => present,
    require => Exec["aptGetUpdate"]
  }

  package { "zlib1g-dev":
    ensure => present,
    require => Exec["aptGetUpdate"]
  }
}