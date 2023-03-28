; Печать символа, пустой строки, цифр, обычной строки - работает

Data SEGMENT
    org 0100h ;смещение от начала базы сегмента
    empty db ?, 13, 10 , "$" ; пустая строка
    symbol db ?, "$" ; символ
    num dw 248 ; число
    string db 'Hello!', "$" ; строка
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

    cmp ax, 0
    je zero_close ; печать, если значение ноль

    next:
        cmp ax, 0
        je pr
        mov bx, 10
        xor dx, dx
        div bx
        add dx, '0'
        push dx
        inc cx
        jmp next
    pr:
        cmp cx, 0
        je close
        pop ax
        call print_char
        dec cx
        jmp pr
    zero_close:
        add ax, '0'
        call print_char
        pop dx
        pop cx
        pop bx
        pop ax
        ret
    close:
        pop dx
        pop cx
        pop bx
        pop ax
        ret
print_num endp

print_char proc ; печать символа
; input
; ax = char
    push ax
    push bx
    push cx
    push dx

    mov symbol, al
    mov AH, 09h
    mov DX, OFFSET symbol
    int 21h

    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_char endp

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

print_string proc ; печать строки
; input
; string db
    push ax
    push bx
    push cx
    push dx

    mov AH, 09h
    mov DX, OFFSET string
    int 21h

    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_string endp

Start:
    mov AX, Data
    mov DS, AX

; печать символа
    mov ax, '5'
    call print_char
; ---
; печать пустой строки
    call print_empty
; ---
; печать цифры
    mov ax, num
    call print_num
    call print_empty
; ---
; печать строки
    call print_string
; ---


    jmp exit
exit:
    mov AL, 0
    mov AH, 4ch
    int 21h
Code ENDS
END Start