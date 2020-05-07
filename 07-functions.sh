#!/bin/bash 

## if we assign a name to set of data then that is a variable 
## id we assign a name to set of commands then that is a function

## Declare a function 

## Method 1 
function SAMPLE() {
  echo Hello from Sample function 
}

## Method 2 

SAMPLE1() {
  echo Hello from Sample1 Function
}

## Access function 
SAMPLE # to call SAMPLE function 
SAMPLE1 # to call SAMPLE1 function

## We cannot use exit commands to come out of function. Exit command will exit the complete the script.
## To come out of a function we need to use return command 

SAMPLE2() {
  echo Hello21
  return 
  echo Hello22
}

SAMPLE2 

## return commands works like exit command for a function, Hence it can come with an exit status of a function.
# return command can return value from 0-255 and as same like exit command.

SAMPLE3() {
  echo Hello22
  return 99
}

SAMPLE3 
echo "Exit Status of SAMPLE3 = $?"

## function can take the arguments like a normal script. Meaning $1-$9, $* , $@,$# are available for functions.
# $0 is not available. $0 is exclusivly reserved for shell script name.

SAMPLE4() {
  echo "First Arg = $1"
  echo "Second Arg = $2"
}

SAMPLE4 10 20

## Function is one type of command. Linux OS will have four types of commands.

## Variable behaviour in function 
## 1. Declare a variable in main program and you can access that in function 
## 2. Declare a variable in function and you can access in main program.
## 3. Variables from main program can be overriden by function and vice-versa.

