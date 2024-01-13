# TP3 Admin : Vagrant

## Sommaire

- [TP3 Admin : Vagrant](#tp3-admin--vagrant)
  - [Sommaire](#sommaire)
- [0. Setup](#0-setup)
  - [Sommaire](#sommaire-1)
  - [0. Intro blabla](#0-intro-blabla)
  - [1. Une première VM](#1-une-première-vm)
  - [2. Repackaging](#2-repackaging)
  - [3. Moult VMs](#3-moult-vms)


## Sommaire

- [TP3 Admin : Vagrant](#tp3-admin--vagrant)
  - [Sommaire](#sommaire)
- [0. Setup](#0-setup)
  - [Sommaire](#sommaire-1)
  - [0. Intro blabla](#0-intro-blabla)
  - [1. Une première VM](#1-une-première-vm)
  - [2. Repackaging](#2-repackaging)
  - [3. Moult VMs](#3-moult-vms)

## 0. Intro blabla

## 1. Une première VM


🌞 **Générer un `Vagrantfile`**




```
 ~/D/2/l/tp3   main ±  mkdir vagrant 
 ~/D/2/l/tp3   main ±  cd vagrant/
 ~/D/2/l/t/vagrant   main ±  ls
 ~/D/2/l/t/vagrant   main ±  mkdir test
 ~/D/2/l/t/vagrant   main ±  cd test/
 ~/D/2/l/t/v/test   main ±  ls
 ~/D/2/l/t/v/test   main ±  vagrant init generic/ubuntu2204
A `Vagrantfile` has been placed in this directory. You are now
ready to `vagrant up` your first virtual environment! Please read
the comments in the Vagrantfile as well as documentation on
`vagrantup.com` for more information on using Vagrant.
 ~/D/2/l/t/v/test   main ±  ls
Vagrantfile
 ~/D/2/l/t/v/test   main ±  cat Vagrantfile 
# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "generic/ubuntu2204"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end

```

🌞 **Modifier le `Vagrantfile`**


```ruby
cat Vagrantfile 
# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "generic/ubuntu2204"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
   config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder ".", "/vagrant", disabled: true
  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end

```

🌞 **Faire joujou avec une VM**

```bash
 ~/D/2/l/t/v/test   main ±  vagrant ssh
vagrant@ubuntu2204:~$ 

```



## 2. Repackaging


🌞 **Repackager la box que vous avez choisie**


```bash
✘  ~/D/2/l/t/v/test   main ±  vagrant package --output super_box.box
==> default: Exporting VM...
==> default: Compressing package to: /home/martin/Documents/2eme-année/linux-b2/tp3/vagrant/test/super_box.box
 ~/D/2/l/t/v/test   main ±  vagrant box add super_box super_box.box
==> box: Box file was not detected as metadata. Adding it directly...
==> box: Adding box 'super_box' (v0) for provider: 
    box: Unpacking necessary files from: file:///home/martin/Documents/2eme-ann%C3%A9e/linux-b2/tp3/vagrant/test/super_box.box
==> box: Successfully added box 'super_box' (v0) for ''!
 ~/D/2/l/t/v/test   main ±  vagrant box listgit add tp3/ ; git commit -m "tp3"; git push


generic/ubuntu2204 (libvirt, 4.3.10)
generic/ubuntu2204 (virtualbox, 4.3.10, (amd64))
super_box          (virtualbox, 0)

```

🌞 **Ecrivez un `Vagrantfile` qui lance une VM à partir de votre Box**
Dans mon Vagrantfile j'ai mis le nom de la box généré :
```
  config.vm.box = "super_box"
```


j'ai rajouter le port 22 sur ma box de base et il est bien la, ca a fonctionné.
```
 ~/D/2/l/t/v/test   main ±  vagrant ssh
Last login: Thu Jan 11 13:27:55 2024 from 10.0.2.2
vagrant@ubuntu2204:~$ ufw status
ERROR: You need to be root to run this script
vagrant@ubuntu2204:~$ sudo !!
sudo ufw status
Status: active

To                         Action      From
--                         ------      ----
22                         ALLOW       Anywhere                  
22 (v6)                    ALLOW       Anywhere (v6) 
```

## 3. Moult VMs



🌞 **Adaptez votre `Vagrantfile`** pour qu'il lance les VMs suivantes (en réutilisant votre box de la partie précédente)


📁 **`partie1/Vagrantfile-3A`** dans le dépôt git de rendu

[Vagrantfile-3A](vagrant/test/partie1/Vagrantfile-3A)
🌞 **Adaptez votre `Vagrantfile`** pour qu'il lance les VMs suivantes (en réutilisant votre box de la partie précédente)

📁 **`partie1/Vagrantfile-3B`** dans le dépôt git de rendu

[Vagrantfile-3B](vagrant/test/partie1/Vagrantfile-3B)
> *La syntaxe Ruby c'est vraiment dégueulasse.*