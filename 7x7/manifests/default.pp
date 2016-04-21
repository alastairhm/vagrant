# Basic Puppet manifest to install Build Essentials, Ruby & Io

class aptupdate {
    exec { 'apt-get update':
        command => '/usr/bin/apt-get update',
    }
}

class ruby {

  #Installs Ruby

  package { "ruby":
    ensure => present,
    require => Class[build],
  }

  package { "libopenssl-ruby":
    ensure => present,
    require => Class[build],
  }

  package { "ruby1.8-dev":
    ensure => present,
    require => Class[build],
  }
}

class build {

  # Install Build Essentials

  package { 'git':
    ensure => 'latest',
  }

  package { 'build-essential':
    ensure => 'latest',
  }

  package { 'cmake':
    ensure => 'latest',
  }

  package { 'vim':
    ensure => 'latest',
    require => Class[aptupdate],
  }

  package { 'unzip':
    ensure => 'latest',
    require => Class[aptupdate],
  }
}

class io {

  #Download, build and install IO Language

  exec { 'gitclone':
    command => "/usr/bin/git clone https://github.com/stevedekorte/io.git /usr/src/io",
    require => Class[build],
    returns => [0,128],
  }

  file { '/usr/src/io/build':
    ensure  => 'directory',
    require => Exec[gitclone],
  }

  exec { 'cmake':
    command => '/usr/bin/cmake ..',
    cwd     => '/usr/src/io/build',
    require => File['/usr/src/io/build'],
  }

  exec { 'make':
    command => '/usr/bin/make',
    cwd     => '/usr/src/io/build',
    require => Exec[cmake],
  }

  exec { 'make install':
    command => '/usr/bin/make install',
    cwd     => '/usr/src/io/build',
    require => Exec[make],
  }
}

class prolog {
  package { "swi-prolog":
    ensure => present,
    require => Class[aptupdate],
  }
}

class scala {
  package { "scala":
    ensure => present,
    require => Class[aptupdate],
  }
}

class erlang {
  package { "erlang-base":
    ensure => present,
    require => Class[aptupdate],
  }
}

class clojure {
  exec { 'download jar':
    command => '/usr/bin/wget http://repo1.maven.org/maven2/org/clojure/clojure/1.5.1/clojure-1.5.1.zip',
    cwd => '/vagrant',
    require => Class[build],
  }

  exec { 'unzip jar':
    command => '/usr/bin/unzip clojure-1.5.1.zip',
    cwd => '/vagrant',
    require => Exec['download jar'],
  }

  file { '/vagrant/clojure':
    ensure => link,
    target => '/vagrant/clojure-1.5.1',
    require => Exec['unzip jar'],
  }
}

class haskell {
  package { "haskell-platform":
    ensure => present,
    require => Class[aptupdate],
  }

  package { "hugs":
    ensure => present,
    require => Class[aptupdate],
  }
}

include aptupdate
include build
include ruby
include io
include prolog
include scala
include erlang
include clojure
include haskell
