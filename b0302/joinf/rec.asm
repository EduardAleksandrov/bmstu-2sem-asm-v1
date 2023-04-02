; рекурсия (Файл пример объединения с print) - работает

EXTRN print_num:far, print_char:far, print_empty:far, print_string:far

Data SEGMENT
    org 0100h ;смещение от начала базы сегмента
    empty db ?, 13, 10 , "$" ; пустая строка
    num dw 5 ; число
Data ENDS

Ourstack SEGMENT Stack
    db 100h DUP (?)
Ourstack ENDS

Code SEGMENT
    ASSUME CS:Code, DS:Data, SS:Ourstack

start:
    mov AX, Data
    mov DS, AX

    mov dx, num
    mov cx, num
m1:
    push dx
    dec dx
    loop m1

    xor ax, ax
    xor dx, dx
    mov ax, 1
    mov cx, num
m2: 
    pop dx
    mul dx   ; результат кладется в ax
    loop m2

; печать цифры
    call print_num
    call print_empty
; ---

    jmp exit
exit:
    mov AL, 0
    mov AH, 4ch
    int 21h
Code ENDS
END Start