VM for working with Jenkin CI Tool

You will need the following installed;

VirtualBox VM https://www.virtualbox.org/
Vagrant       http://www.vagrantup.com/

Installs Apache, Ruby and Jenkins on a Ubuntu precise 32 

Port forwards 127.0.0.1:8080 to VM:8080 (Jenkins)

Port forwards 127.0.0.1:9090 to VM:80	(Apache)

Port forwards 127.0.0.1:1234 to VM:4567 (Ruby Sinatra)

Now stores config in the Vagrant shared folder so it persists between sessions;

/var/lib/jenkins soft linked to /vargrant/jenkins



