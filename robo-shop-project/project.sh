#/bin/bash

RB="\e[0m\e[1;31m"
GB="\e[0m\e[1;32m"
YB="\e[0m\e[1;33m"
BB="\e[0m\e[1;34m"
MB="\e[0m\e[1;35m"
CB="\e[0m\e[1;36m"
N="\e[0m"
D="\e[0m\e[2m"
B="\e[0m\e[1m"
##RB-Red Bold, GB-Green Bold,---and so on
#N--> Nutralize the color
#D-->varaibale for dim color
#B-->Variable for bold color
echo -e "${BB}[MONGO][INFO] ${D}$(date +%F' '%T)${B}MONGODB INSTALL${N}"