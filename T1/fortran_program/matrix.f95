program matrix_program
    implicit none

    character(len=32) :: arg
    integer :: size, type, t1, t2, cr, cm
    real(8) :: rate
    integer, dimension(:,:), allocatable :: matrix
    integer, dimension (:), allocatable :: vector
    integer, dimension (:), allocatable :: result

    CALL system_clock(count_rate=cr)
    CALL system_clock(count_max=cm)
    rate = REAL(cr)
    
    call getarg(1, arg)    
    read(arg, "(I10)") size

    call getarg(2, arg)    
    read(arg, "(I1)") type

    allocate(matrix(size, size))
    allocate(vector(size))
    allocate(result(size))

    call random_seed()

    call generateMatrix(matrix, size)
    call generateVector(vector, size)

    if (type == 0) then
        call system_clock(t1)
        call multiplicationIJ(size, matrix, vector, result)
        call system_clock(t2)
    
    else
        call system_clock(t1)
        call multiplicationJI(size, matrix, vector, result)
        call system_clock(t2)
    end if
    
    deallocate(matrix)
    deallocate(vector)
    deallocate(result)

    WRITE(*,*) "Tempo : ",(t2 - t1)/rate

    contains

    subroutine generateVector(vector, size)
        implicit none
        integer, dimension(:) :: vector  
        integer :: size, i, n
        real(8) :: n_real
        do i=1, size
            call random_number(n_real)
            n = nint(n_real)
            vector(i) = n * size
        end do
    end

    subroutine generateMatrix(matrix, size)
        implicit none
        integer, dimension(:,:) :: matrix
        integer :: size, i, j, n
        real(8) :: n_real

        do i = 1, size
            do j = 1, size
                call random_number(n_real)
                n = nint(n_real)
                matrix(i, j) = n * size
            end do
        end do 
    end

    subroutine multiplicationIJ(size, matrix, vector, result)
        implicit none

        integer, dimension (:) :: vector
        integer, dimension (:, :) :: matrix
        integer, dimension (:) :: result
        integer :: i, j, size

        do i = 1, size
            result(i) = 0
        end do 

        do i = 1, size
            do j = 1, size
                result(i) = result(i) +  matrix(i, j) * vector(j);
            end do
        end do
    end

    subroutine multiplicationJI(size, matrix, vector, result)
        implicit none

        integer, dimension (:) :: vector
        integer, dimension (:, :) :: matrix
        integer, dimension (:) :: result
        integer :: i, j, size

        do i = 1, size
            result(i) = 0
        end do 

        do j = 1, size
            do i =1 , size
                result(i) = result(i) +  matrix(i, j) * vector(j);
            end do
        end do
    end

end program matrix_program



