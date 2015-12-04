# README
## About

## Getting Started
### Prerequisites
 - Install [Vagrant](https://www.vagrantup.com/downloads.html)
  - Select the OS that you're working with
  - Download and run the installer
 - Install [hostmanager](https://github.com/smdahlen/vagrant-hostmanager) vagrant plugin
  - Open a terminal window in which ever OS you're working in
  - Enter the command `vagrant plugin install vagrant-hostmanager`
### Required
 - favourite editor
 - browser
 - contributing idea

### Usage

### Development

## Repo Flow
- Vagrantfile for FreeCodeCamp
  - Vagrant will spin up Ubuntu 14.04 (Trusty)
    - Machine will be provisioned by puppet
      - Puppet:: Apt-Get update
      - Puppet:: Dev Tools _( [module listed below](https://github.com/freecodecamp/fcc-vagrant#devtools-puppet-module) )_
      - Puppet:: Node.js (v4.2.2)
      - Puppet:: MongoDB
      - Puppet:: Freecodecamp _( [module listed below](https://github.com/freecodecamp/fcc-vagrant#freecodecamp-puppet-module) )_
  - Vagrant will create sync folder
    - Sync:: ./freecodecamp -> /home/vagrant/freecodecamp

#### DevTools Puppet Module:
 - `git`
 - `m4`
 - `ruby`
 - `vim-common`
 - `curl`
 - `htop`
 - `g++`
 - `build-essential`
 - `texinfo`
 - `libbz2-dev`
 - `libcurl4-openssl-dev`
 - `libexpat-dev`
 - `libncurses-dev`
 - `zlib1g-dev`

#### Freecodecamp Puppet Module:
 - `git clone freecodecamp` repo
 - `npm config set jobs 1`
 - `touch .env` file
 - `npm install -g babel@5.8.29`