# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
current_dir    = File.dirname(File.expand_path(__FILE__))
configs        = YAML.load_file("#{current_dir}/config.yaml")
vagrant_config = configs['configs'][configs['configs']['use']]

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  #config.vm.box = "kevinmellott91/ubuntu-16.04-desktop-amd64"
  config.vm.box = "marcoaltieri/ubuntu-desktop-16.04-64bit"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "syncData", "/vagrant_data"

  config.ssh.username = "vagrant"
  config.ssh.password = "vagrant"

  config.vm.network "private_network", ip: "192.168.50.4"

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
  
    # Customize the amount of memory on the VM:
    vb.customize ["modifyvm", :id, "--memory", vagrant_config['ram']]

    # enable 3D acceleration
    vb.customize ["modifyvm", :id, "--accelerate3d", "on"]

    #
    # Run Ansible from the Vagrant Host
    #
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = "tasks/main.yml"
      ansible.vault_password_file = ".vault_password_file"
    end

  end
end
