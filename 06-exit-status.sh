#/bin/bash

#Every command send a status back after which execution and that status is called exit status.

##Exit states are 0-255

#0-success
#1-255-not success/ partail success/partial failure

## System by default will store the last command of exit status in (?)questionmark varaibla.
 
 exit 1

 ## Values from 126-255 are used by system , Hence it is not  recomended to use those values.