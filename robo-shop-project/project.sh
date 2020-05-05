#/bin/bash

RB="\e[1;31m"
GB="\e[1;32m"
YB="\e[1;33m"
BB="\e[1;34m"
MB="\e[1;35m"
CB="\e[1;36m"
N="\e[0m"
D="\e[2m"
B="\e[1m"
##RB-Red Bold, GB-Green Bold,---and so on
#N--> Nutralize the color
#D-->varaibale for dim color
#B-->Variable for bold color
echo -e "${BB}[MONGO]${N}[INFO]${N} ${D}$(date +%F' '%T) ${B}MONGODB INSTALL${N}"