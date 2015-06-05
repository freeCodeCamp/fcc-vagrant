#README
 - This repo is currently incomplete (Updated: 2015-06-05)
 
##Pre-req
 - Vagrant installed
 - hostmanager vagrant plugin installed

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