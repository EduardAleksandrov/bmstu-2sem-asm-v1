Data SEGMENT
    greet db 'Hello!', 13, 10 , "$"
Data ENDS

Ourstack SEGMENT Stack
    db 100h DUP (?)
Ourstack ENDS

ASSUME CS:Code, DS:Data, SS:Ourstack

Code SEGMENT
Start:
    mov AX, Data
    mov DS, AX

    mov AH, 09h
    mov DX, OFFSET greet
    int 21h

    mov AL, 0
    mov AH, 4ch
    int 21h
Code ENDS
END Start
; Строка на экран