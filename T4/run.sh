NORMAL_PROGRAM=laplace.cxx
OPENMP_PROGRAM=openmp_laplace.cxx

MAX_THREADS=6

echo 'Nx,Result,Time,Threads,Flags' > output.csv

echo "Normal program without flags"
g++ $NORMAL_PROGRAM -o laplace 
for nx in 512 1024 2048;
do
    echo $nx 1000 10e-16 "None" > input.txt
    echo $(./laplace < input.txt >> output.csv) "Nx = $nx"
done

echo "Normal program with O3 flag"
g++ -O3 $NORMAL_PROGRAM -o laplace 
for nx in 512 1024 2048;
do
    echo $nx 1000 10e-16 "O3" > input.txt
    echo $(./laplace < input.txt >> output.csv) "Nx = $nx"
done

echo "OpenMP program without flags"
g++ $OPENMP_PROGRAM -fopenmp -o laplace 
for count in $(seq 1 $MAX_THREADS);
do
    echo "Threads = $count"
    export OMP_NUM_THREADS=$count
    for nx in 512 1024 2048;
    do
        echo $nx 1000 10e-16 "fopenmp" > input.txt
        echo $(./laplace < input.txt >> output.csv) "Nx = $nx"
    done
done
  

echo "OpenMP program with O3 flag"
g++ $OPENMP_PROGRAM -fopenmp -O3 -o laplace 
for count in $(seq 1 $MAX_THREADS);
do
    echo "Threads = $count"
    export OMP_NUM_THREADS=$count
    for nx in 512 1024 2048;
    do
        echo $nx 1000 10e-16 "fopenmp+O3" > input.txt
        echo $(./laplace < input.txt >> output.csv) "Nx = $nx"
    done
done

rm laplace
rm input.txt





