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
echo -e "${BB}[MONGODB]${B}[INFO] ${D}$(date +%F' '%T) ${B}MONGODB INSTALL${N}"
echo -e "${BB}[RABITMQ]${B}[INFO] ${D}$(date +%F' '%T) ${B}RABITMQ INSTALL${N}"
echo -e "${BB}[MYSQL]${B}[INFO] ${D}$(date +%F' '%T) ${B}MYSQL INSTALL${N}"
echo -e "${BB}[REDIS]${B}[INFO] ${D}$(date +%F' '%T) ${B}REDIS INSTALL${N}"

echo -e "${MB}[NGINX]${B}[INFO] ${D}$(date +%F' '%T) ${B}NGINX INSTALL${N}"

echo -e "${CB}[CATALOGUE]${B}[INFO] ${D}$(date +%F' '%T) ${B}CATALOGUE INSTALL${N}"
echo -e "${CB}[CART]${B}[INFO] ${D}$(date +%F' '%T) ${B}CART INSTALL${N}"
echo -e "${CB}[USER]${B}[INFO] ${D}$(date +%F' '%T) ${B}USER INSTALL${N}"
echo -e "${CB}[SHIPPING]${B}[INFO] ${D}$(date +%F' '%T) ${B}SHIPPING INSTALL${N}"
echo -e "${CB}[PAYMENT]${B}[INFO] ${D}$(date +%F' '%T) ${B}PAYMENT INSTALL${N}"