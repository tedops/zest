#!/bin/bash

ports=($(seq 6000 7000))

for p in ${ports[@]}; do
    sudo lsof -i :$p -t 2>&1 > /dev/null
    [[ $? -eq 0 ]] && continue || { echo $p ; break ; }
done
