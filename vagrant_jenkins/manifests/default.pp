# Basic Puppet manifest to install Apache, Ruby & Jenkins

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

class jenkins {

    exec { 'add-key' :
        command => '/usr/bin/wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | /usr/bin/apt-key add -',
#	unless => "/usr/bin/apt-key list | /bin/grep 1024D/D50582E6",
    }
    
    exec { 'add-repo' :
        command => '/bin/echo "deb http://pkg.jenkins-ci.org/debian binary/" > /etc/apt/sources.list.d/jenkins.list',
        require => Exec[add-key],
    }
    
    exec { 'apt-update' :
        command => '/usr/bin/apt-get update',
        refreshonly => true,
        require => Exec[add-repo],
    }

#    exec { 'restore-jenkins' :
#	cwd     => '/',
#	command => 'tar -xf /vagrant/jenkins.tar',
#	path    => '/bin',
#    }
    
    package { 'subversion' :
        ensure => 'latest',
    }

    package { 'jenkins':
        ensure => 'latest',
        #require => [Exec[apt-update],Exec[restore-jenkins]],
        require => [Exec[apt-update]],
    }
}

include apache
include ruby
include hiera
include jenkins
