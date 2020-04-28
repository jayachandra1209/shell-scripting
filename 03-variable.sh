#!/bin/bash

#Varaiable is a name which is associated to a set of data.
## Advantage is change of data in one place will replicate in so all the places where that varaible is used.

## Declearation of Varaible
a=10 #number
b=xyz #Character
c=r100 #string

## Observation is :
#Shell doesnot have data types, unlike other scripting langauges by default.
#Every thing is a string.

##Access Variables are
echo a=$a
echo b = ${b}

#both are above are same
echo $a100
echo ${a}100

#And also braces used for arrays.

#Requirement is : print welcome message along with todays date

DATE=2020-03-28
echo welcome, Today date is $DATE

# The problem with above command is , printing same date for all the days.

#so the varaible here is called static varaible(means no change), Static varaibles cant be the solution all the time

# So we will use Dynamic Variable

#Dynamic Variable are two typs:
#1.Command Substitution  syntax is: a=$(command) or a=`command`
#2.Arithematic Substitution Syntax is: a=$((arithematic expression))

DATE=$(date +%F)
echo welcome, Today date is $DATE

ADD=$((100+20+10))
echo $ADD

## Due to limitations arithematic expressions may not use it all times.
# problems are
#1. base
echo $((09+01))
#2. Float
echo $((99.99-9.09))
## execute the above values you will get the errors. 

## Alternative is bc command. We need to install this if we will use this bc command

#Environment Variables.

echo COURSE NAME=$COURSENAME