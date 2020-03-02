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

#checking for the player who play first
function toss()
{
	playerCheck=$((RANDOM%2))
	if (($playerCheck==0))
	then
		echo "player x will play first"
	else
		echo "player o will play first"
	fi
}

#game board
function board()
{
	for ((i=0; i<$ROW; i++))
	do
		for ((j=0; j<$COLUMN; j++))
		do
			printf "|${index[$i,$j]}|"
		done
			echo " "
	done
}
