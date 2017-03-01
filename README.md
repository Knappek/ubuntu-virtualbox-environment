# Ubuntu Setup

This project will set up a Virtual machine in VirtualBox using Vagrant where the machine is provisioned using Ansible. The VM contains the following setup:
* Ubuntu 16.04 LTS (Xenial Xerus)
* ChefDK (optional)
* some Ubuntu packages and Ruby gems
* some workspace directories (optional)
* Atom editor (optional)
* Visual Studio Code Editor (optional)

## Requirements
* Download VirtualBox: https://www.virtualbox.org/wiki/Downloads.
* Make sure you have the Oracle VM VirtualBox Extension Pack installed: https://www.virtualbox.org/wiki/Downloads
* Download and Install Vagrant: https://www.vagrantup.com/downloads.html

Usage
-----

### on UNIX OS

#### Requirements
* Install Git command line tool: https://git-scm.com/downloads
* Install Ansible: http://docs.ansible.com/ansible/intro_installation.html

#### Setup

1. Clone this project: `git clone https://github.com/Knappek/ansible.git`
2. Open config.yml and determine if you are in office or home and adjust the parameters
  1. `unix`: choose `yes` as you are working on a UNIX based OS.
  2. `ram`: ram size in MB (string)
  3. `hdd_size_in_gb`: hard drive disk size in GB (integer)
  4. `swap_size_in_gb`: Swap size in GB (integer)
3. make sure to fulfill the prerequisites
4. Open `roles/ubuntu.chef-workspace/defaults/main.yml`
  1. Set `vagrant_setup` to `yes`
  2. change the username
  3. Create a sha-512 hashed User Password and paste it to `user_password`:
    1. open https://www.mkpasswd.net/index.php
    2. enter your password
    3. choose type `crypt-sha512`
    4. click `Hash` and copy and paste the output to `user_password`
    5. check the other variables and adapt them to your wishes
5. `vars_files`:
  1. delete the encrypted file `roles/ubuntu.chef-workspace/vars/git-credentials.yml as you need to create a new one with your own encryption key
  2. create a file called `.vault_password_file` in the same directory as the `Vagrantfile`. This file should include your personal password which will be used to encrypt and decrypt files
  3. go to directory `roles/ubuntu.chef-workspace/vars` in your shell
  4. run: `ansible-vault create git-credentials.yml`, enter your password which you have placed into `.vault_password_file` and add this content to that file:

    ```yml

    ---
    git:
      user: <username>
      password: <your password>

    ```

    where you replace `<username>` and `<your password>` with you git username and password
6. start the VirtualBox
7. go back to the root directory of this project in your shell and run `vagrant up`
8. That's it, your VM will be created in the VirtualBox.


### on Windows (or separately created VM with another provider such as VMWare)

#### Requirements
* Install Git command line tool: https://git-scm.com/downloads

#### Setup

If you have already created a VM in your VirtualBox (or VMWare) then you can skip steps 1.-5, although it is highly recommended to start from point zero to not have any unexpected problems.

1. Clone this project: `git clone https://github.com/Knappek/ansible.git`
2. Open config.yml and determine if you are in office or home and adjust the parameters
  1. `unix`: Choose `no`
  2. `ram`: ram size in MB (string)
  3. `hdd_size_in_gb`: hard drive disk size in GB (integer)
  4. `swap_size_in_gb`: Swap size in GB (integer)
3. start the VirtualBox
4. open a shell (e.g. Git Bash), cd to the directory of the `Vagrantfile` and run `vagrant up`
5. After the VM has been created, log in with the `vagrant` user and `vagrant` password
6. Open the terminal
7. Run: `sudo apt-get install build-essential libssl-dev libffi-dev python-dev vim git python-pip`
8. Run: `pip install ansible`
9. Clone this project: `git clone https://github.com/Knappek/ansible.git`
10. Open `roles/ubuntu.chef-workspace/defaults/main.yml`
11. Set `vagrant_setup` to `no` if you have created the VM manually (hence if you skipped steps 1-5)
12. change the username
13. Create a sha-512 hashed User Password and paste it to `user_password`:
  1. open https://www.mkpasswd.net/index.php
  2. enter your password
  3. choose type `crypt-sha512`
  4. click `Hash` and copy and paste the output to `user_password`
14. check the other variables and adapt them to your wishes
15. If you have chosen `yes` for the variable `create_workspace`  do the following steps:
    1. delete the encrypted file `roles/ubuntu.chef-workspace/vars/git-credentials.yml as you need to create a new one with your own encryption key
    2. create a file called `.vault_password_file` in the same directory as the `sity.yml`. This file should include your personal password which will be used to encrypt and decrypt files
    3. go to directory `roles/ubuntu.chef-workspace/vars` in your shell
    4. run: `ansible-vault create git-credentials.yml`, enter your password which you have placed into `.vault_password_file` and add this content to that file:

    ```yml

    ---
    git:
      user: <username>
      password: <your password>

    ```

    where you replace `<username>` and `<your password>` with you git username and password

16. in the same directory as `sity.yml` run
    ```bash
    ansible-playbook site.yml --vault-password .vault_password_file --connection=local
    ```


Debug
-----

Here are possible errors during `vagrant up` or `vagrant provision`.

### Error 1

There is an error during `vagrant up`:

```

==> default: mesg:
==> default: ttyname failed
==> default: :
==> default: Inappropriate ioctl for device

```

### Solution 1
can be just ignored



### Error 2
`Could not get lock /var/lib/apt/lists/lock - open (11: Resource temporarily unavailable)\n`

### Solution 2
run `vagrant up` or `vagrant provision` again.
