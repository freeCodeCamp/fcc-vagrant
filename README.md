# README
 - This repo is currently incomplete (Updated: 2015-06-05)

## Pre-req
 - Vagrant installed
 - hostmanager vagrant plugin installed

## Vagrant Flow
- Vagrant will spin up Ubuntu 14.04 (trusty64)
- Vagrant will create sync folder
 - Sync:: ./freecodecamp -> /home/vagrant/developer/freecodecamp
- Vagrantfile for FreeCodeCamp
  - Puppet:: apt-get update
  - Puppet:: othertools
  - Puppet:: nodejs
  - Puppet:: mongodb
  - Puppet:: corefcc
    - Puppet:: git clone fcc
    - Puppet:: ownership node/npm
    - Puppet:: limit npm jobs
    - Puppet:: npm install -g babel@5.8.29
    - Puppet:: npm install --loglevel silent
    - Puppet:: npm install -g gulp
    - Puppet:: npm install -g bower
    - Puppet:: bower install
    - Puppet:: env-file -> developer/freecodecamp
    - Puppet:: run seeding

npm config jobs
