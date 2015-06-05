#LIST OF THINGS

###Short Term
- Update the README.md
 - Add link for Vagrant
  - Instructions for installing Vagrant
 - Add link for host manager plugin
  - Instructions for installing plugin
- Create 'fccuser' 
 - Add to 'vagrant' group
 - Add to sudoers group

###Mid Term
- Install linuxbrew under 'fccuser'
 - run command to install linuxbrew
 - edit the PATH variable
  - custom .bashrc file (?)
- Install node as 'fccuser'

###Long Term
- Clone FCC repo to /home/fccuser/developer/freecodecamp
- Set the share/swap directory as easily configurable by the user (if they have a local fork to keep the vagrant freecodecamp pointed at their local file system)
 - Not really sure what this means? (-afro)
- Profit?

###BONUS
- Set up mongo to listen to an ip other than localhost on a port other than 27017.

####NOTES
- must have hostmanager vagrant plugin installed (add to readme)

```
useradd -s /bin/bash -m -d /home/safeuser -c "safe user” fccuser
passwd safeuser
webdev
usermod -aG sudo fccuser
```