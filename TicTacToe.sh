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
#check the player
function checkPlayer()
{
randomCheck=$((RANDOM%2))
	if (($randomCheck==0))
	then
		player=X
	else
		player=O
	fi
		echo $player
}
