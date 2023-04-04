; превращение введенного символа цифры в цифру - работает

Data SEGMENT
    org 0100h ;смещение от начала базы сегмента
    empty db ?, 13, 10 , "$" ; пустая строка
Data ENDS

Ourstack SEGMENT Stack
    db 100h DUP (?)
Ourstack ENDS

Code SEGMENT
    ASSUME CS:Code, DS:Data, SS:Ourstack

start:
    mov AX, Data
    mov DS, AX

    xor ax, ax
    mov ah, 01h
    int 21h

    ; mov number, al ; d al записывается значение ascii кода в виде строки
    xor ah, ah
    sub ax, '0' ; превращение строки в число
    ; mov al, num

; печать цифры
    call print_num
    call print_empty
; ---

    jmp exit
exit:
    mov AL, 0
    mov AH, 4ch
    int 21h

print_num proc; печать цифр
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

print_empty proc; печать пустой строки
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
Code ENDS
END Start