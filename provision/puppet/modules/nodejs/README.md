### Global Variables
  - version: version of node
  - bin: default bin dirs to use
  - user: user to install nvm under
  - home: user home directory

### Usage

```puppet
class { 'nodejs::globals':
  # Global variables here
}->
class { 'nodejs': }
```