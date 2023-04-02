; Печать символа, пустой строки, печать цифр изолирована от символов (Файл для объединения) - работает

public print_num, print_char, print_empty, print_string

Data SEGMENT
    org 0100h ;смещение от начала базы сегмента
    empty db ?, 13, 10 , "$" ; пустая строка
    symbol db ?, "$" ; символ
    num dw 60 ; число
    string db 'Hello!', "$" ; строка
Data ENDS

Code SEGMENT
    ASSUME CS:Code, DS:Data
print_num proc far; печать цифр
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

print_char proc far; печать символа
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

print_empty proc far; печать пустой строки
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

print_string proc far; печать строки
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
Code ENDS
END 