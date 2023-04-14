; Замена местами второго и четвертого символа - работает

Data SEGMENT
    empty db ?, 13, 10 , "$" ; пустая строка
    string db  'abcdefg', "$"
    len = $-string-1
Data ENDS

Ourstack SEGMENT Stack
    db 100h DUP (?)
Ourstack ENDS

Code SEGMENT
    ASSUME CS:Code, DS:Data, SS:Ourstack
Start:
    mov AX, Data
    mov DS, AX
; первый вывод
    mov bx, offset string
    call print_str
    mov bx, offset empty
    call print_str
; вывод обменяли символ

    mov bx, offset string
    call xchange_simbol
    call print_str

    jmp exit
exit:
    mov AL, 0
    mov AH, 4ch
    int 21h

xchange_simbol proc
; input bx
; output bx
    mov al, [bx+1]
    xchg al, [bx+3]
    mov [bx+1], al
    ret
xchange_simbol endp

print_str proc ; печать пустой строки
; input
; bx = string
    push ax
    push bx
    push cx
    push dx

    xor ax, ax
    mov AH, 09h
    mov DX, bx
    int 21h

    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_str endp

Code ENDS
END Start