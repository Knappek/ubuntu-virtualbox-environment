# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
current_dir    = File.dirname(File.expand_path(__FILE__))
configs        = YAML.load_file("#{current_dir}/config.yml")
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
  # config.vm.box = "geerlingguy/ubuntu1604"


  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "syncData", "/vagrant_data"

  config.ssh.username = "vagrant"
  config.ssh.password = "vagrant"

  
  file_to_disk = "ext_hdd_disk.vdi"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "ubuntu1604"
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
  
    # Customize the amount of memory on the VM:
    vb.customize ["modifyvm", :id, "--memory", vagrant_config['ram']]

    # enable 3D acceleration
    vb.customize ["modifyvm", :id, "--accelerate3d", "on"]

    # Validate this should be run it once
    if ARGV[0] == "up" && ! File.exist?(file_to_disk)
      vb.customize [
        'createhd',
        '--filename', file_to_disk,
        '--format', 'VDI',
        '--size', (vagrant_config['hdd_size_in_gb'] * 1024).to_s
      ]

      vb.customize [
        'storageattach', :id,
        '--storagectl', "SATA",
        '--port', 1, '--device', 0,
        '--type', 'hdd', '--medium', 
        file_to_disk
      ]
    end
  end

  if ARGV[0] == "up" && ! File.exist?(file_to_disk)
    # Run script to map new disk
    config.vm.provision "shell", path: "bootstrap.sh"
    # Run script to increase swap memory
    config.vm.provision "shell", path: "increase_swap.sh", args: (vagrant_config['swap_size_in_gb'] * 1000).to_s
  end

  # Run Ansible from the Vagrant Host
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "tasks/main.yml"
    ansible.vault_password_file = ".vault_password_file"
  end

end
