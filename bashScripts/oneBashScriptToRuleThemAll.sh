#!/bin/bash

# Number of times to repeat the sequence
n=1  # Set this to the number of times you want to repeat the sequence

# List of scripts to execute
scripts=("script01.sh" "script02.sh" "script03.sh" "script04.sh" "script05.sh" "script06.sh" "script07.sh" "script08.sh" "script09.sh" "script10.sh" "script11.sh" "script12.sh")

# Function to shuffle the array of scripts randomly
shuffle(){
    local i tmp size max rand
    size=${#scripts[@]}
    max=$((32768 / size * size))
    for ((i = size - 1; i >= 0; i--)); do
        rand=$RANDOM
        while (( rand >= max )); do
            rand=$RANDOM
        done
        tmp=${scripts[i]}
        j=$((rand % (i + 1)))
        scripts[i]=${scripts[j]}
        scripts[j]=$tmp
    done
}

# Main loop to repeat the process n times
for ((i = 1; i <= n; i++))
do
    echo "Iteration $i"

    shuffle

    for script in "${scripts[@]}"
    do
        echo "Running $script"
        ./$script
    done  # End of inner for loop
done  # End of outer for loop

 
 


#for ((i = 1; i<=n; i++))
#do
#    ./script01.sh
#    ./script02.sh
#    ./script03.sh
#    ./script04.sh
#    ./script05.sh

 #   done
  




