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

