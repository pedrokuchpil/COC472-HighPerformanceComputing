#include <stdio.h>
#include <sys/time.h>
#include <time.h>
#include <stdlib.h>

int generateNumber()
{
    int r = rand();
    return r;
}

int *generateVector(int size)
{
    int *vector = (int *)malloc((size + 1) * sizeof(int));
    for (int i = 0; i < size; i++)
    {
        vector[i] = generateNumber();
    }
    return vector;
}

int **generateMatrix(int size)
{
    int **matrix = (int **)malloc((size + 1) * sizeof(int *));
    for (int i = 0; i < size; i++)
    {
        matrix[i] = (int *)malloc((size + 1) * sizeof(int));
        matrix[i] = generateVector(size);
    }

    return matrix;
}

void freeMatrix(int **matrix, int size)
{
    for (int i = 0; i < size ; i++)
    {
        free(matrix[i]);
    }
    free(matrix);
}

int *multiplication_IJ(int size, int **matrix, int *vector)
{
    int *result = (int *)malloc((size + 1) * sizeof(int *));
    for (int i = 0; i < size; i++)
    {
        result[i] = 0;
    }

    for (int i = 0; i < size; i++)
    {
        for (int j = 0; j < size; j++)
        {
            result[i] += matrix[i][j] * vector[j];
        }
    }

    return result;
}

int *multiplication_JI(int size, int **matrix, int *vector)
{
    int *result = (int *)malloc((size + 1) * sizeof(int *));
    for (int i = 0; i < size; i++)
    {
        result[i] = 0;
    }

    for (int j = 0; j < size; j++)
    {
        for (int i = 0; i < size; i++)
        {
            result[i] += matrix[i][j] * vector[j];
        }
    }

    return result;
}

int main (int argc, char *argv[]) 
{
    srand(time(NULL));
    struct timeval t1, t2;
    double elapsedTime;

    gettimeofday(&t1, NULL);
    gettimeofday(&t2, NULL);
    
    int size = atoi(argv[1]);
    int type = atoi(argv[2]);

    int **matrix = generateMatrix(size);

    int *vector = generateVector(size);

    int *result;

    if (type == 0)
    {
        gettimeofday(&t1, NULL);
        result = multiplication_IJ(size, matrix, vector);
        gettimeofday(&t2, NULL);
    }

    else 
    {
        gettimeofday(&t1, NULL);
        result = multiplication_JI(size, matrix, vector);
        gettimeofday(&t2, NULL);
    }
    
    
    freeMatrix(matrix, size);
    free(vector);
    free(result);

    elapsedTime = (t2.tv_sec - t1.tv_sec) * 1000.0;      // sec to ms
    elapsedTime += (t2.tv_usec - t1.tv_usec) / 1000.0;   // us to ms
    printf("%f ms\n", elapsedTime);


    return 0;
}