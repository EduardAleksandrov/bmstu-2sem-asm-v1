Data SEGMENT
    org 0100h ;смещение от начала базы сегмента
    greet dw 1
Data ENDS

Ourstack SEGMENT Stack
    db 100h DUP (?)
Ourstack ENDS

ASSUME CS:Code, DS:Data, SS:Ourstack

Code SEGMENT
Start:
    mov AX, Data
    mov DS, AX

    mov AH, 02
    mov BX, offset greet ; запись адреса переменной greet, а не его значения
    mov byte ptr [BX], 8 ; по адресу который хранится в bx записать число восемь
    mov DX, greet
    int 21h

    mov AX, [BX] ; помещаем значение по адресу, которых хранится в bx

    mov BX, 0
    mov BX, [greet] ; ничего не происходит, как будто нет скобок

    mov AL, 0
    mov AH, 4ch
    int 21h
Code ENDS
END Start
;расчеты с адресацией