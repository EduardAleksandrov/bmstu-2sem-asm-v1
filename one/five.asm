Data SEGMENT
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
    mov DX, greet
    add dx, 1
    mov greet, dx
    int 21h

    mov AL, 0
    mov AH, 4ch
    int 21h
Code ENDS
END Start
; Число на экран
