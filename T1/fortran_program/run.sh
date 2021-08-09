#!/bin/bash

gfortran -o matrix matrix.f95

for i in $(seq 1 28);
do
    echo "$i"
    ./matrix $(($i*1000)) 0
    ./matrix $(($i*1000)) 1
done