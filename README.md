#README
 - This repo is currently incomplete (Updated: 2015-06-05)
 
##Pre-req
 - Install [Vagrant](https://www.vagrantup.com/downloads.html)
  - Select the OS that you're working with
  - Download and run the installer
 - Install [hostmanager](https://github.com/smdahlen/vagrant-hostmanager) vagrant plugin
  - Open a terminal window in which ever OS you're working in
  - Enter the command `vagrant plugin install vagrant-hostmanager`

##Repo Flow
- Vagrantfile for FreeCodeCamp
 - Vagrant will spin up Ubuntu 14.04 (Trusty)
  - Machine will be provisioned by puppet
   - Puppet:: Node.js
   - Puppet:: MongoDB
   - Puppet:: Tools (Git, Vim, Curl, HTOP)
   - Puppet:: Ruby, G++, Build-Essentials
  - Vagrant will create sync folder
   - Sync:: ./freecodecamp -> /home/fccuser/developer/freecodecamp