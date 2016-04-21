# Website Cloning with Ruby

class aptupdate {
    exec { 'apt-get update':
        command => '/usr/bin/apt-get update',
    }
}

class gitinstall {
    package { "git-core":
    ensure => present,
    require => Class["aptupdate"],    
    }
}

class ruby {

#  package { "ruby":
#    ensure => present,
#  }
  
  package { "build-essential":
    ensure => present,
    require => Class["aptupdate"],    
  }  

  package { "libopenssl-ruby":
    ensure => present,
    require => Class["aptupdate"],    
  }  

  package { "ruby1.8-dev":
    ensure => present,
    require => Class["aptupdate"],    
  }  
}

class mysql {
  package { "mysql-server":
    ensure => present,
    require => Class["aptupdate"],
  }
 
  service { "mysql":
    ensure => running,
    require => Package["mysql-server"],
  }
 
  exec { "set-mysql-password":
    unless  => "mysql -uroot -proot",
    path    => ["/bin", "/usr/bin"],
    command => "mysqladmin -uroot password root",
    require => Service["mysql"],
 
  }
 
#  exec { "create-database":
#    unless  => "/usr/bin/mysql -usite_development -psite_development site_development",
#    command => "/usr/bin/mysql -uroot -proot -e \"create database site_development; grant all on site_development.* to site_dev@localhost identified by 'site_development';\"",
#    require => Service["mysql"],
#  }
}

class datamapper {
   package { "libmysqlclient-dev":
      ensure => present,
      require => Class["aptupdate"],
   }

   package { 'data_mapper':
        ensure   => 'installed',
        provider => 'gem',
        require => Class["ruby"],
    }
}

class sinatra {
    package { 'sinatra':
        ensure   => 'installed',
        provider => 'gem',
        require => Class["ruby"],
    }
}

class haml {
    package { 'haml':
        ensure   => 'installed',
        provider => 'gem',
        require => Class["ruby"],
    }
}

class blueprintcss {
    package { 'wget':
        ensure => 'installed',
        require => Class["aptupdate"],
    }

   package { "unzip":
      ensure => present,
      require => Class["aptupdate"],
   }
   
   exec { 'blueprintzip':
        command => '/usr/bin/wget https://github.com/joshuaclayton/blueprint-css/archive/master.zip',
	cwd => "/tmp",
        require => Package['wget'],
        notify  => Exec['unzip-blueprintzip'], 
   }
   
   exec { 'unzip-blueprintzip':
		command => "/usr/bin/unzip master.zip",
		cwd     => "/tmp",
		creates => "/tmp/blueprint-css-master",
		require => [Package["unzip"], Exec["blueprintzip"]],
   }
}

#System Setup
include aptupdate
include gitinstall
include mysql
include ruby
#Ruby GEM installs
include sinatra
include haml
include datamapper
#CSS Library
include blueprintcss
