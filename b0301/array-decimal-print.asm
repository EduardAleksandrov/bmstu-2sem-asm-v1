; Печать десятичного значения

Data SEGMENT
    org 0100h ;смещение от начала базы сегмента
    greet db ' ', 13, 10 , "$" ; пустая строка
    array dw 1,2,27,10,5
    ten dw 10
Data ENDS

Ourstack SEGMENT Stack
    db 100h DUP (?)
Ourstack ENDS

ASSUME CS:Code, DS:Data, SS:Ourstack

Code SEGMENT
print_result proc ; результат для десятичных значений, входящее значение в bx
    ; mov ax, bx
    ; aam
    xor dx, dx
    mov ax, bx
    div ten
    mov bx, dx ; первая цифра, 0 разряд справа
    cmp ax, 0
    je p1

    mov dx, ax ; вторая цифра, 1 разряд справа
    mov ah, 2h
    add dx, '0' ;преобразовываем цифру в ASCII символ
    int 21h
    
p1: 
    mov dx, bx 
    mov ah, 2h
    add dx, '0' ;преобразовываем цифру в ASCII символ
    int 21h

    ret
print_result endp

print_empty proc ; пустая строка
    mov AH, 09h
    mov DX, OFFSET greet
    int 21h
    ret
print_empty endp

Start:
    mov AX, Data
    mov DS, AX
    
    mov si, offset array
    mov cx, 5
m1:
    mov bx, [si]
    add si, 2
    call print_result
    call print_empty
    loop m1

    jmp exit
    
exit:
    mov AL, 0
    mov AH, 4ch
    int 21h
Code ENDS
END Start