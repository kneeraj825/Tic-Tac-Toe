#!/bin/bash -x

echo ____________Welcome_______________
ROW=3
COLUMN=3
#Resetting the board
function reset()
{
	for ((i=0; i<$ROW; i++))
	do
		for ((j=0; j<$COLUMN; j++))
		do
			index[$i,$j]=0
		done
	done
}
