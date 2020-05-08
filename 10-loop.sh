#!/bin/bash

## Loops are fundamentally two types in shell, Another two are the inverse of the main two loops.

# For Loop      -> Select Loop (Reverse of For loop logic)
# While Loop    -> Until Loop (Reverse of While Loop Logic)

# Loops works in iterations. Any loop works on controlling the number of iterations.

# For loop works on inputs 
# while loop works on expressions used in if condition.

for country in Kolkata Kuala_Lumpur Tokyo; do 
  echo $country 
  curl -s "http://worldtimeapi.org/api/timezone/Asia/$country" | jq .datetime
done

i=10

while [ $i -gt 0 ]; do 
  echo Iteration $i 
  i=$(($i-1))
done 
