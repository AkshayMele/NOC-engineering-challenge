#!/bin/bash

# Initialize an array with numbers 1 through 10
numbers=(1 2 3 4 5 6 7 8 9 10)
len=${#numbers[@]}

# Fisher-Yates shuffle
for (( i=len-1; i>0; i-- )); do
	# Generate a random index between 0 and i
	j=$(( RANDOM % (i+1) ))

	# Swap elements at index i and j
	temp=${numbers[i]}
	numbers[i]=${numbers[j]}
	numbers[j]=$temp
done

# Print the shuffled numbers, one per line
for n in "${numbers[@]}"; do
    echo "$n"
done