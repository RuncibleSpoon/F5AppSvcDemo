#!/bin/bash 
# Count the Blue Green Ratio
COUNT=0
TESTS=100
BLUE=0
GREEN=0
while [ $COUNT -lt $TESTS ]; do
   FOUND=`curl -s bigip | grep -c "Blue"` 	 
   #echo $FOUND
   let BLUE=$BLUE+$FOUND
   #echo $BLUE
   let COUNT=COUNT+1
done  
let BLUE=BLUE/2
echo "Blue Server Hit $BLUE times"
let GREEN=TESTS-BLUE
echo "Green Server Hit $GREEN times"
