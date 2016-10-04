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
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # install Ubuntu 16.04
  config.vm.box = "ubuntu/xenial64"
  config.vm.hostname = "Ubuntu-16.04"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "syncData", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
    # TODO 
    # http://stackoverflow.com/questions/18878117/using-vagrant-to-run-virtual-machines-with-desktop-environment
    #

  
    # Customize the amount of memory on the VM:
    vb.customize ["modifyvm", :id, "--memory", vagrant_config['ram']]

    # enable 3D acceleration
    vb.customize ["modifyvm", :id, "--accelerate3d", "on"]

    # TODO
    # enable guest addition: https://gist.github.com/fernandoaleman/5083680
  end
   
  # Disable the new default behavior introduced in Vagrant 1.7, to
  # ensure that all Vagrant machines will use the same SSH key pair.
  # See https://github.com/mitchellh/vagrant/issues/5005
  config.ssh.insert_key = false

  # provision VM with Ansible
 # config.vm.provision "ansible" do |ansible|
 #    ansible.verbose = "v"
 #    ansible.playbook = "playbook.yml"
 # end
end
