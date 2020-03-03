#!/bin/bash -x

echo ____________Welcome_______________
ROW=3
COLUMN=3
LAST=1
LENGTH=$(($ROW*$COLUMN))
declare -A index
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

function limit()
{
	for ((count=0; count<$ROW; count++))
	do
		for ((count2=0; count2<$COLUMN; count2++))
		do
			index[$count,$count2]=$LAST
			((LAST++))
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

function playerInput()
{
	for ((count=0; count<$LENGTH; count++))
	do
		board
		read -p "enter the position" position
		if [ $position -gt $LENGTH ]
		then
			echo "Invalid Number"
			((count--))
		else
			rowNumber=$(($position / $ROW))
			if [ $(($position % $ROW)) -eq 0 ]
			then
				rowNumber=$(($rowNumber-1))
			fi
 				columnNumber=$(($position % $COLUMN))
				if (($columnNumber == 0))
				then
					columnNumber=$(($columnNumber+2))
				else
					columnNumber=$(($columnNumber-1))
				fi
				index[$rowNumber,$columnNumber]=$player
				if [ $(firstDiagonal) -eq 1 ]
				then
					echo "Winner"
					return 0
				fi
		fi
	done
}

#winner function
function firstDiagonal()
{
	if [ ${index[0,0]} == $player ] && [ ${index[0,1]} == $player ] && [ ${index[0,2]} == $player ]
	then
		echo 1
	elif [ ${index[1,0]} == $player ] && [ ${index[1,1]} == $player ] && [ ${index[1,2]} == $player ]
	then
		echo 1
	elif [ ${index[2,0]} == $player ] && [ ${index[2,1]} == $player ] && [ ${index[2,2]} == $player ]
	then
		echo 1
	elif [ ${index[0,0]} == $player ] && [ ${index[1,0]} == $player ] && [ ${index[2,0]} == $player ]
	then
		echo 1
	elif [ ${index[0,2]} == $player ] && [ ${index[1,2]} == $player ] && [ ${index[2,2]} == $player ]
	then
		echo 1
	elif [ ${index[0,1]} == $player ] && [ ${index[1,1]} == $player ] && [ ${index[2,1]} == $player ]
		then
		echo 1
	elif [ ${index[0,0]} == $player ] && [ ${index[1,1]} == $player ] && [ ${index[2,2]} == $player ]
	then
		echo 1
	elif [ ${index[0,2]} == $player ] && [ ${index[1,1]} == $player ] && [ ${index[2,0]} == $player ]	
	then
		echo 1
	else
	echo 0
	fi
}
reset
limit
checkPlayer
toss
playerInput
board
