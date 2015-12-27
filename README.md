![freecodecamp banner](https://s3.amazonaws.com/freecodecamp/wide-social-banner.png)

# README
## About
Contributing to a project can be difficult at times. The project might require a lot of configuration and some tools that you might not have installed on your local machine.

The point of this project is to give you an environment which you can use to help develop FreeCodeCamp.

<img src="http://cdn.phys.org/newman/gfx/news/hires/2014/1-organictinin.jpg" width="600" alt="image of still air container">

You spin up the environment, make your contribution, and create a pull request.

## Getting Started
### Prerequisites
 - Install [Vagrant](https://www.vagrantup.com/downloads.html)
  - Select the OS that you're working with
  - Download and run the installer (may require system restart)
  - Confirm Vagrant is installed
    - Open a terminal window in which ever OS you're working in
    - Enter the command `vagrant --version`
    - Result should be `Vagrant 1.7.4` (as of this commit)
 - Install [hostmanager](https://github.com/smdahlen/vagrant-hostmanager) vagrant plugin
  - Open a terminal window in which ever OS you're working in
  - Enter the command `vagrant plugin install vagrant-hostmanager`

### Required
 - favourite editor
 - browser
 - contributing idea

### Usage
(How to use this repo)

### Development
(How to develope and contribute with this repo)

## Repo Flow
- Vagrantfile for FreeCodeCamp
  - Vagrant will spin up Ubuntu 14.04 (Trusty)
    - Machine will be provisioned by puppet
      - Puppet:: Apt-Get update
      - Puppet:: Dev Tools _( [module listed below](https://github.com/freecodecamp/fcc-vagrant#devtools-puppet-module) )_
      - Puppet:: Node.js (v4.2.2)
      - Puppet:: MongoDB
      - Puppet:: Freecodecamp _( [module listed below](https://github.com/freecodecamp/fcc-vagrant#freecodecamp-puppet-module) )_ _(currently removed)_
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

#### Freecodecamp Puppet Module: _(currently removed)_
 - `git clone freecodecamp` repo
 - `npm config set jobs 1`
 - `touch .env` file
 - `npm install -g babel@5.8.29`