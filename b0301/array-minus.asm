Data SEGMENT
    org 0100h ;смещение от начала базы сегмента
    greet db ' ', 13, 10 , "$" ; пустая строка
    array dw 1,2,3,-4,5
Data ENDS

Ourstack SEGMENT Stack
    db 100h DUP (?)
Ourstack ENDS

ASSUME CS:Code, DS:Data, SS:Ourstack

Code SEGMENT
print_result proc ; результат
    mov ah, 2h
    mov dx, bx
    add dx, '0'
    int 21h
    ret
print_result endp

Start:
    mov AX, Data
    mov DS, AX
    
    mov si, offset array
    mov cx, 5
m1:
    mov bx, [si]
    add si, 2
    call print_result
    loop m1

    jmp exit
    
exit:
    mov AL, 0
    mov AH, 4ch
    int 21h
Code ENDS
END Start