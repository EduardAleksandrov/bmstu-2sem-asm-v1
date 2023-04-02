; уже не рекурсия, сокращенная без стека, просто расчет факториала - работает

Data SEGMENT
    org 0100h ;смещение от начала базы сегмента
    empty db ?, 13, 10 , "$" ; пустая строка
    num dw 4 ; число
Data ENDS

Ourstack SEGMENT Stack
    db 100h DUP (?)
Ourstack ENDS

Code SEGMENT
    ASSUME CS:Code, DS:Data, SS:Ourstack
print_num proc ; печать цифр
; input
; ax = integer
    push ax
    push bx
    push cx
    push dx
    xor cx, cx
    next:
        mov bx, 10
        xor dx, dx
        div bx
        add dx, '0'
        push dx
        inc cx
        
        cmp ax, 0
        je pr

        jmp next
    pr:
        cmp cx, 0
        je close
        
        pop dx
        mov ah, 2h ; печать, input = dx
        int 21h

        dec cx
        jmp pr
    close:
        pop dx
        pop cx
        pop bx
        pop ax
        ret
print_num endp


print_empty proc ; печать пустой строки
; input
; ax = char
    push ax
    push bx
    push cx
    push dx

    mov AH, 09h
    mov DX, OFFSET empty
    int 21h

    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_empty endp

start:
    mov AX, Data
    mov DS, AX

    mov bx, num
    mov cx, num
    mov ax, 1
m1:
    mul bx
    dec bx
    loop m1

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