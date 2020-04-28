# Script exampls for future use.
#!/bin/bash

while true ; do

  if [ ! -f /tmp/aws-hostname ]; then
    REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/[a-z]$//')
    aws ec2 describe-instances --region $REGION &>/dev/null
    [ $? -ne 0 ] && break
    INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
    AWS_HOSTNAME=$(aws ec2 describe-instances --region $REGION --instance-ids $INSTANCE_ID --query "Reservations[*].Instances[*].[Tags[*]]" | grep Name -B1  | head -1 | grep Value  |xargs | awk -F : '{print $2}' | sed -e 's/,//g' -e 's/ //g')
    echo $AWS_HOSTNAME >/tmp/aws-hostname
    break
  fi
  AWS_HOSTNAME=$(cat /tmp/aws-hostname 2>/dev/null)
  break
done

if [ -z "$AWS_HOSTNAME" ]; then
    if [ `id -u` = 0 ]; then
      export PS1='\[\e[1;31m\][\u@\h \W]# \[\e[0m\]'
    else
      export PS1='\[\e[1;31m\][\u@\h \W]$ \[\e[0m\]'
    fi

else
    if [ `id -u` = 0 ]; then
      export PS1='\[\e[1;31m\][\u@$AWS_HOSTNAME \W]# \[\e[0m\]'
    else
      export PS1='\[\e[1;31m\][\u@$AWS_HOSTNAME \W]$ \[\e[0m\]'
    fi
fi