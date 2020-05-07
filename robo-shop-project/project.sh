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
#echo -e "${BB}[MONGODB]${B}[INFO] ${D}$(date +%F' '%T) ${B}MONGODB INSTALL${N}"
#echo -e "${BB}[RABITMQ]${B}[INFO] ${D}$(date +%F' '%T) ${B}RABITMQ INSTALL${N}"
#echo -e "${BB}[MYSQL]${B}[INFO] ${D}$(date +%F' '%T) ${B}MYSQL INSTALL${N}"
#echo -e "${BB}[REDIS]${B}[INFO] ${D}$(date +%F' '%T) ${B}REDIS INSTALL${N}"

#echo -e "${MB}[NGINX]${B}[INFO] ${D}$(date +%F' '%T) ${B}NGINX INSTALL${N}"

#echo -e "${CB}[CATALOGUE]${B}[INFO] ${D}$(date +%F' '%T) ${B}CATALOGUE INSTALL${N}"
#echo -e "${CB}[CART]${B}[INFO] ${D}$(date +%F' '%T) ${B}CART INSTALL${N}"
#echo -e "${CB}[USER]${B}[INFO] ${D}$(date +%F' '%T) ${B}USER INSTALL${N}"
#echo -e "${CB}[SHIPPING]${B}[INFO] ${D}$(date +%F' '%T) ${B}SHIPPING INSTALL${N}"
#echo -e "${CB}[PAYMENT]${B}[INFO] ${D}$(date +%F' '%T) ${B}PAYMENT INSTALL${N}"

LOG_FILE=/tmp/project.log
rm -f LOG_FILE

## Check GIT credential variables

if [ -z "$GIT_USER"]; then
 echo -e "\n $RB GIT_USER varaible is missing, export GIT_USER and try again \n"
 exit 1
fi 

if [ -z "$GIT_PASSWORD"]; then
 echo -e "\n $RB GIT_PASSWORD variable is missing, export GIT_PASSWORD and try again \n"
 exit 1
fi 

LOGGER() {
    
    case $1 in
    INFO)
    STAT_COLOR=${B}
    ;;
    FAIL)
    STAT_COLOR=${RB}
    ;;
    SUCC)
    STAT_COLOR=${GB}
    ;;
    SKIP) 
      STAT_COLOR=${YB}
   esac

    case $SERVICE_NAME in 
    MONGODB|RABBITMQ|MYSQL|REDIS)
    echo -e "${D}$(date +%F' '%T) ${STAT_COLOR}[$1] ${BB}[$SERVICE_NAME] ${B}${2}${N}"
    ;;
    NGINX)
    echo -e "${D}$(date +%F' '%T) ${STAT_COLOR}[$1] ${MB}[$SERVICE_NAME] ${B}${2}${N}"
    ;;
    CATALOGUE|CART|USER|SHIPPING|DISPATCH|PAYMENT)
    echo -e "${D}$(date +%F' '%T) ${STAT_COLOR}[$1] ${CB}[$SERVICE_NAME] ${B}${2}${N}"
    ;;
    esac
    }

STAT() {
  case $1 in 
    SKIP) 
      LOGGER SKIP "$2"
      ;;
    0) 
      LOGGER SUCC "$2"
      ;; 
    *) 
      LOGGER FAIL "$2"
      ;;
  esac
}

CLONE()
{
    mkdir -p /tmp/robo-shop 
    cd /tmp/robo-shop
    if [ -d "$1" ]; then
     cd $1
     git pull &>>$LOG_FILE
     STAT $? "Pulling repositry"
    else
     git clone https://${GIT_USER}:${GIT_PASSWORD}@gitlab.com/batch46/robo-shop/${1}.git
     STAT $? "Cloning Repository"
    fi
}

## Main Program
SERVICE_NAME=MONGODB
LOGGER INFO "Starting MongoDB Setup"
echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb-org-4.2.repo 
STAT $? "Setting Up YUM Repository"

yum install -y mongodb-org  &>>$LOG_FILE 
STAT $? "Installing MongoDB"

systemctl enable mongod &>>$LOG_FILE 
systemctl start mongod &>>$LOG_FILE 
STAT $? "Starting MongoDB Service"


SERVICE_NAME=RABBITMQ
LOGGER INFO "Starting RABBITMQ Setup"
yum list installed | grep erlang &>/dev/null
case $? in 
  0) 
    STAT SKIP "Installing ErLang Package"
    ;;
  *) 
    yum install https://packages.erlang-solutions.com/erlang/rpm/centos/7/x86_64/esl-erlang_22.2.1-1~centos~7_amd64.rpm -y   &>>$LOG_FILE 
    STAT $? "Installing ErLang Package"
    ;;
esac

curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>$LOG_FILE 
STAT $? "Setting up Yum repos"

yum install rabbitmq-server -y &>>$LOG_FILE 
STAT $? "Installing RabbitMQ Server"

systemctl enable rabbitmq-server &>>$LOG_FILE
systemctl start rabbitmq-server &>>$LOG_FILE
STAT $? "Starting RabbitMQ Server"




SERVICE_NAME=MYSQL 
LOGGER INFO "Starting MYSQL Setup"

yum remove mariadb-libs -y &>/dev/null
yum list installed | grep mysql-community-server &>/dev/null
case $? in 
  0) 
    STAT SKIP "Downloading MYSQL"
    ;;
  *) 
    LOGGER INFO "Downloading MYSQL"
    wget https://downloads.mysql.com/archives/get/p/23/file/mysql-5.7.28-1.el7.x86_64.rpm-bundle.tar  -O /tmp/mysql-5.7.28-1.el7.x86_64.rpm-bundle.tar &>>$LOG_FILE 
    STAT $? "Downloading MYSQL"
    cd /tmp
    tar -xf mysql-5.7.28-1.el7.x86_64.rpm-bundle.tar 
    yum install mysql-community-client-5.7.28-1.el7.x86_64.rpm \
              mysql-community-common-5.7.28-1.el7.x86_64.rpm \
              mysql-community-libs-5.7.28-1.el7.x86_64.rpm \
              mysql-community-server-5.7.28-1.el7.x86_64.rpm -y &>>$LOG_FILE 
    STAT $? "Installing MySQL Database"
    rm -rf mysql-5* *.rpm
    ;;
esac
systemctl enable mysqld &>>$LOG_FILE 
systemctl start mysqld &>>$LOG_FILE 
STAT $? "Starting MySQL Database"

SERVICE_NAME=REDIS
LOGGER INFO "Starting REDIS Setup"

yum install epel-release yum-utils -y &>>$LOG_FILE 
STAT $? "Installing EPEL & YUM UTILS Package"

yum list installed | grep remi-release &>/dev/null
case $? in
0) 
    STAT SKIP "Setting Up YUM Repos"
    ;;
*)
    yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>>$LOG_FILE
    STAT $? "Setting Up YUM Repos"
    yum-config-manager --enable remi &>/dev/null
    ;;
esac

yum install redis -y &>>$LOG_FILE
STAT $? "Installing REDIS"

systemctl enable redis &>>$LOG_FILE
systemctl start redis &>>$LOG_FILE
STAT $? "Starting REDIS Service"




SERVICE_NAME=NGINX
LOGGER INFO "Starting NGINX Setup"

yum install nginx -y &>>$LOG_FILE
stat $? "Installaing Nginx"

CLONE nginx-webapp
