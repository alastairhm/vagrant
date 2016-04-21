# Basic Puppet manifest to install Apache, Ruby & Hudson

class apache {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }

  package { "apache2":
    ensure => present,
  }

  service { "apache2":
    ensure => running,
    require => Package["apache2"],
  }

  file { '/var/www':
    ensure => link,
    target => "/vagrant",
    notify => Service['apache2'],
    force  => true
  }
}

class ruby {

  package { "ruby":
    ensure => present,
  }
  
  package { "build-essential":
    ensure => present,
  }  

  package { "libopenssl-ruby":
    ensure => present,
  }  

  package { "ruby1.8-dev":
    ensure => present,
  }  
    
}

class hiera {
    package { 'hiera':
        ensure => 'installed',
        provider => 'gem',
    }
    package { 'hiera-puppet':
        ensure => 'installed',
        provider => 'gem',
    }    
}

class hudson {
  
    exec { 'add-repo' :
        command => '/bin/echo "deb http://hudson-ci.org/debian binary/" > /etc/apt/sources.list.d/hudson.list',
    }
    
    exec { 'apt-update' :
        command => '/usr/bin/apt-get update',
        require => Exec[add-repo],
    }

    package { 'hudson':
        ensure => 'installed',
        install_options => ['y','--force-yes'],
        require => Exec[apt-update],
    }
}

include apache
include ruby
include hiera
include hudson
