; транспонирование матрицы, из лекции (сделано на лабораторной) - работает
DSEG Segment
    nmax dw 4
    n dw 4
    x db '1234'
      db '1234'
      db '1234'
      db '1234'
      db '$'
DSEG ENDS

CSEG Segment
ASSUME CS:CSEG, DS:DSEG, SS:SSEG
START:
    mov ax, DSEG
    mov ds, ax

    mov bx, 1
    mov dx, nmax
    mov cx, n
    dec cx
    m1: 
        push cx
        mov si, bx
        mov di, dx
    m2:
        mov al, x[si]
        xchg al, x[di]
        xchg al, x[si]
        add di, nmax
        inc si
        loop m2
        add dx, nmax
        inc dx
        add bx, nmax
        inc bx
        pop cx
        loop m1

    ; выводим строку
    mov AH, 09h
    mov DX, OFFSET x
    int 21h


    mov ah, 4ch
    int 21h
CSEG ENDS

SSEG Segment Stack
    dw 64 dup(0)
SSEG ENDS
    END START
