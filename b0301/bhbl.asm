; task: запись в регистры bl, bh

Data SEGMENT
    array dw 4,2,1,9,5
Data ENDS

Ourstack SEGMENT Stack
    db 100h DUP (?)
Ourstack ENDS

Code SEGMENT
    ASSUME CS:Code, DS:Data, SS:Ourstack
Start:
    mov AX, Data
    mov DS, AX

    mov bl, 4
    mov bh, 3
    mov bx, 8

prt:
    mov ah, 2h
    mov dx, bx
    add dx, '0' ; преобразовываем цифру в ASCII символ
    int 21h
    
exit:
    mov AL, 0
    mov AH, 4ch
    int 21h
Code ENDS
END Start