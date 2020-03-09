#!/bin/bash -x

echo ____________Welcome_______________

#CONSTANTS
ROW=3
COLUMN=3
LENGTH=$(($ROW*$COLUMN))

#VARIABLE
LAST=1

declare -A index

#RESETTING THE index
function reset(){
	for (( i=0; i<$ROW; i++ ))
	do
		for (( j=0; count1<$j; j++ ))
		do
			index[$i,$j]=0
		done
	done
}

#INITIALIZING BOARD
function initializeBoard(){
	for (( i=0; i<ROW; i++ ))
	do
		for (( j=0; j<COLUMN; j++ ))
		do
			index[$i,$j]=$LAST
			((LAST++))
		done
	done
}

#ASSIGNING PLAYER'S SYMBOL
function checkPlayer(){
	if [ $((RANDOM%2)) -eq 0 ]
	then
		Player=X
		Computer=O
	else
		Computer=X
		Player=O
	fi
	echo "Symbol for Player is "$Player
}

#TOSS
function toss(){
	if [ $((RANDOM%2)) -eq 0 ]
	then
		flag=1
		echo "Player turn"
	else
		flag=0
		echo "Computer turn"
	fi
}

#DISPLAY BOARD
function board(){
for ((i=0; i<$ROW; i++))
	do
		for ((j=0; j<$COLUMN; j++))
		do
			printf "|${index[$i,$j]}|"
		done
			echo " "	
	done
}

#GETTING INPUT
function getInput(){
	for (( i=0; i<$LENGTH; i++ ))
	do
 		board
		if [ $flag -eq 1 ]
		then
			read -p "Enter a position " position
			if [ $position -gt $LENGTH ]
			then
				echo "Invalid Moves"
				((i--))
				else
					rowIndex=$(( $position / $ROW ))
				if [ $(( $position % $ROW )) -eq 0 ]
				then
					rowIndex=$(( $rowIndex-1 ))
				fi
					columnIndex=$(( $position % $COLUMN ))
				if [ $columnIndex -eq 0 ]
				then
					columnIndex=$(($columnIndex+2))
				else
					columnIndex=$(($columnIndex-1))
				fi
				#CHECKING VALIDATION FOR OVERLAPPING
				if [ "${index[$rowIndex,$columnIndex]}" == "$Player" ] || [ "${index[$rowIndex,$columnIndex]}" == "$Computer" ]
				then
					echo "Invalid move, Cell already filled"
					printf "\n"
					((i--))
				else
					index[$rowIndex,$columnIndex]=$Player
					flag=0
					if [ $(checkResult $Player) -eq 1 ]
					then
						echo "You Win"
						return 0
					fi
				fi
			fi
      	else
				echo "Computer Turn"
				computerTurn
				flag=1
			if [ $(checkResult $Computer) -eq 1 ]
			then
				echo "Computer Won"
				return 0
			fi
		fi
	done
		echo "Match Tie"
}

#CHECK'S WINNER
function checkResult(){
   turn=$1
   if [ ${index[0,0]} == $turn ] && [ ${index[0,1]} == $turn ] && [ ${index[0,2]} == $turn ]
   then
      echo 1
   elif [ ${index[1,0]} == $turn ] && [ ${index[1,1]} == $turn ] && [ ${index[1,2]} == $turn ]
   then
      echo 1
   elif [ ${index[2,0]} == $turn ] && [ ${index[2,1]} == $turn ] && [ ${index[2,2]} == $turn ]
   then
      echo 1
   elif [ ${index[0,0]} == $turn ] && [ ${index[1,0]} == $turn ] && [ ${index[2,0]} == $turn ]
   then
      echo 1
   elif [ ${index[0,1]} == $turn ] && [ ${index[1,1]} == $turn ] && [ ${index[2,1]} == $turn ]
   then
      echo 1
   elif [ ${index[0,2]} == $turn ] && [ ${index[1,2]} == $turn ] && [ ${index[2,2]} == $turn ]
   then
      echo 1
   elif [ ${index[0,0]} == $turn ] && [ ${index[1,1]} == $turn ] && [ ${index[2,2]} == $turn ]
   then
      echo 1
   elif [ ${index[0,2]} == $turn ] && [ ${index[1,1]} == $turn ] && [ ${index[2,0]} == $turn ]
   then
      echo 1
   else
      echo 0
   fi
}

function  computerTurn(){
   #checking the rOWS
	local row=0
	local col=0
   for ((row=0; row<ROW; row++))
   do
      if [ ${index[$row,$col]} == $Player ] && [ ${index[$(($row)),$(($col+1))]} == $Player ]
      then
          if [ ${index[$row,$(($col+2))]} != $Computer ]
          then
             index[$row,$(($col+2))]=$Computer
             break
          fi
      elif [ ${index[$row,$(($col+1))]} == $Player ] && [ ${index[$row,$(($col+2))]} == $Player ]
      then
          if [ ${index[$row,$col]} != $Computer ]
          then
             index[$row,$col]=$Computer
             break
          fi
      elif [ ${index[$row,$col]} == $Player ] && [ ${index[$row,$(($col+2))]} == $Player ]
      then
          if [ ${index[$row,$(($col+1))]} != $Computer ]
          then
             index[$row,$(($col+1))]=$Computer
             break
          fi
      fi
   done

   #checking the column
   local row=0
   local col=0
   for ((col=0; col<COLUMN; col++))
   do
      if [ ${index[$row,$col]} == $Player ] &&  [ ${index[$(($row+1)),$col]} == $Player ]
      then
         if [ ${index[$(($row+2)),$col]} != $Computer ]
         then
            index[$(($row+2)),$col]=$Computer
            break
         fi
      elif [ ${index[$(($row+1)),$col]} == $Player ] && [ ${index[$(($row+2)),$col]} == $Player ]
      then
         if [ ${index[$row,$col]} != $Computer ]
         then
            index[$row,$col]=$Computer
            break
          fi
      elif [ ${index[$row,$col]} == $Player ] && [ ${index[$(($row+2)),$col]} == $Player ]
      then
         if [ ${index[$(($row+1)),$col]} != $Computer ]
         then
            index[$(($row+1)),$col]=$Computer
            break
         fi
      fi
   done

#checking the dIAGONAL
local row=0
local col=0
if [ ${index[$row,$col]} == $Player ] &&  [ ${index[$(($row+1)),$(($col+1))]} == $Player ]
then
	if [ ${index[$(($row+2)),$(($col+2))]} != $Computer ]
	then
		index[$(($row+2)),$(($col+2))]=$Computer
		return
	fi
	elif [ ${index[$(($row+1)),$(($col+1))]} == $Player ] && [ ${index[$(($row+2)),$(($col+2))]} == $Player ]
	then
		if [ ${index[$row,$col]} != $Computer ]
		then
			index[$row,$col]=$Computer
 			return
 		fi
		elif [ ${index[$row,$col]} == $Player ] && [ ${index[$(($row+2)),$(($col+2))]} == $Player ]
		then
		if [ ${index[$(($row+1)),$(($col+1))]} != $Computer ]
		then
			index[$(($row+1)),$(($col+1))]=$Computer
			return
		fi
 		elif [ ${index[$(($row+2)),$col]} == $Player ] &&  [ ${index[$(($row+1)),$(($col+1))]} == $Player ]
		then
			if [ ${index[$row,$(($col+2))]} != $Computer ]
			then
				index[$row,$(($col+2))]=$Computer
				return
			fi
			elif [ ${index[$(($row+1)),$(($col+1))]} == $Player ] && [ ${index[$row,$(($col+2))]} == $Player ]
			then
				if [ ${index[$(($row+2)),$col]} != $Computer ]
				then
					index[$(($row+2)),$col]=$Computer
					return
			fi
			elif [ ${index[$(($row+2)),$col]} == $Player ] && [ ${index[$row,$(($col+2))]} == $Player ]
			then
				if [ ${index[$(($row+1)),$(($col+1))]} != $Computer ]
				then
					index[$(($row+1)),$(($col+1))]=$Computer
					return
			fi
			else
			while [ true ]
			do
				local row=$(( RANDOM % $ROW ))
				local col=$(( RANDOM % $COLUMN ))
				if [ ${index[$row,$col]} == $Player ] || [ ${index[$row,$col]} == $Computer ]
				then
				continue
				else
					index[$row,$col]=$Computer
					break
			fi
		done
	fi
}

# Checking for the computer win
function checkComputerWin()
{
	#ROW
	local row=0
	local col=0
	for ((row=0; row<ROW; row++))
	do
		if [ ${index[$row,$col]} == $Computer ] && [ ${index[$(($row)),$(($col+1))]} == $Computer ]
		then
			if [ ${index[$row,$(($col+2))]} != $Player ]
			then
				index[$row,$(($col+2))]=$Computer
				break
			fi
			elif [ ${index[$row,$(($col+1))]} == $Computer ] && [ ${index[$row,$(($col+2))]} == $Computer ]
			then
				if [ ${index[$row,$col]} != $Player ]
				then
					index[$row,$col]=$Computer
					break
				fi
				elif [ ${index[$row,$col]} == $Computer ] && [ ${index[$row,$(($col+2))]} == $Computer ]
				then
					if [ ${index[$row,$(($col+1))]} != $Player ]
					then
						index[$row,$(($col+1))]=$Computer
						break
					fi
				fi
	done
}

reset
checkPlayer
toss
initializeBoard
getInput
board
checkComputerWin
