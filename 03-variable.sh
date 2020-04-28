#!/bin/bash

#Varaiable is a name which is associated to a set of data.
## Advantage is change of data in one place will replicate in so all the places where that varaible is used.

## Declearation of Varaible
a=10 #number
b=xyz #Character
c=r100 #string
d=20.90 #float

## Observation is :
#Shell doesnot have data types, unlike other scripting langauges by default.
#Every thing is a string.

##Access Variables are
echo a=$a
echo b = ${b}

#both are above are same