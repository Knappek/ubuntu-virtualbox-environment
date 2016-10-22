# Ubuntu Setup

This project will set up a Virtual machine in VirtualBox using Vagrant where the machine is provisioned using Ansible. The VM contains the following setup:
* Ubuntu 16.04 LTS (Xenial Xerus)
* ChefDK
* some workspace directories

## Requirements
* Download VirtualBox: https://www.virtualbox.org/wiki/Downloads. 
* Make sure you have the Oracle VM VirtualBox Extension Pack installed: https://www.virtualbox.org/wiki/Downloads
* Download and Install Vagrant: https://www.vagrantup.com/downloads.html
* Install Git command line tool: https://git-scm.com/downloads
* Install Ansible: http://docs.ansible.com/ansible/intro_installation.html



Usage
-----

1. Open config.yml and determine if you are in office or home and adjust the parameters
  1. `ram`: ram size in MB (string)
  2. `hdd_size_in_gb`: hard drive disk size in GB (integer)
  3. `swap_size_in_gb`: Swap size in GB (integer)
3. make sure to fulfill the prerequisites
4. Open tasks/main.yml
5. change the username
6. Create a sha-512 hashed User Password: 
  1. open https://www.mkpasswd.net/index.php
  2. enter your password
  3. choose type `crypt-sha512`
  4. click `Hash` and copy and paste the output to `user_password`
7. `keyboard_layout`: Choose your favourite keyboad language (`de`: German, `us`: English)
8. check the other variables and adapt them to your wishes
9. `vars_files`: 
  1. delete the encrypted file files/git-credentials.yml as you need to create a new one with your own encryption key
  2. create a file called `.vault_password_file` in the same directory as the Vagrantfile. This file should include your personal password which will be used to encrypt and decrypt files
  3. go to directory `files` in your shell
  4. run: `ansible-vault create git-credentials.yml`, enter your password which you have placed into `.vault_password_file` and add this content to that file:
  
    ```yml

    ---
    git: 
      user: <username>
      password: <your password>

    ```
10. start the VirtualBox
11. go back to the directory `Ubuntu1604` in your terminal and run `vagrant up`
12. That's it, your VM will be created in the VirtualBox. 



