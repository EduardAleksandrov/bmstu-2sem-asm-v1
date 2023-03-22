; нахождение максимума в массиве v1, не готовая

Data SEGMENT
    ; org 0100h ;смещение от начала базы сегмента
    ; greet dw 1
    array dw 1,2,3,4,5
Data ENDS

Ourstack SEGMENT Stack
    db 100h DUP (?)
Ourstack ENDS

ASSUME CS:Code, DS:Data, SS:Ourstack

Code SEGMENT
Start:
    mov AX, Data
    mov DS, AX

    mov si, 0
    mov cx, 5
    xor bx, bx
m1: 
    cmp array[si], bx
    jg max
    ; cmp array[si], bx
    ; jl min
    jmp m2
; min: 
;     mov bx, ax
;     jmp m2
max:
    mov bx, array[si]
m2:
    add si, 2
    loop m1

    ; mov bx, array[si+2]
    mov ah, 2h
    mov dx, bx
    add dx, '0'
    int 21h

    mov AL, 0
    mov AH, 4ch
    int 21h
Code ENDS
END Start