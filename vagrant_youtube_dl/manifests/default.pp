# Basic Puppet manifest to install Ruby

class aptupdate {

  # Make sure repo libs are up to date

  exec { 'apt-get update':
      command => '/usr/bin/apt-get update',
  }
}

class build {

  # Install Build Essentials, Git, VIM etc

  package { 'curl':
    ensure => 'latest',
    require => Class[aptupdate],
  }

  package { 'git':
    ensure => 'latest',
    require => Class[aptupdate],
  }

  package { 'build-essential':
    ensure => 'latest',
    require => Class[aptupdate],
  }

  package { 'cmake':
    ensure => 'latest',
    require => Class[aptupdate],
  }

  package { 'vim':
    ensure => 'latest',
    require => Class[aptupdate],
  }

  package { 'unzip':
    ensure => 'latest',
    require => Class[aptupdate],
  }

  package { 'ffmpeg':
    ensure => 'latest',
    require => Class[aptupdate],
  }

  package { 'ubuntu-restricted-extras':
    ensure => 'latest',
    require => Class[aptupdate],
  }
}

class ruby {

  # Install ruby

  package { "ruby":
    ensure => latest,
  }

  package { "libopenssl-ruby":
    ensure => latest,
    require => Package["ruby"],
  }

  package { "ruby1.8-dev":
    ensure => latest,
    require => Package["ruby"],
  }

  package { 'twitter':
      ensure => 'installed',
      provider => 'gem',
      require => [Class['build'],Package['ruby'],Package['ruby1.8-dev']],
  }
}

class youtube-dl {
  exec { 'download':
    command => '/usr/bin/curl https://yt-dl.org/downloads/2014.08.10/youtube-dl -o /usr/local/bin/youtube-dl',
    require => Class['build'],
  }

  exec {'permissions':
    command => '/bin/chmod a+x /usr/local/bin/youtube-dl',
    require => Exec['download'],
  }
}

include aptupdate
include build
include ruby
include youtube-dl
