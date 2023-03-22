; печать в регистре bl работает

Data SEGMENT
    x db 5,6
Data ENDS

Ourstack SEGMENT Stack
    db 100h DUP (?)
Ourstack ENDS

ASSUME CS:Code, DS:Data, SS:Ourstack

Code SEGMENT
printr MACRO ; результат в цифровом виде, входящее значение в bx
    mov ah, 2h
    mov dl, bl
    add dl, '0' ; преобразовываем цифру в ASCII символ
    int 21h
endm

Start:
    mov AX, Data
    mov DS, AX

    mov si, offset x
    mov cx, 2
m1:
    mov bl, [si]
    add si, 1
    printr
    loop m1

    jmp exit
    
exit:
    mov AL, 0
    mov AH, 4ch
    int 21h
Code ENDS
END Start