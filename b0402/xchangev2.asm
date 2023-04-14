; вывод перевернутой строки - работает

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

; вывод обменяли символы
    mov bx, offset string
    call xchange_all_simbols
    call print_str

    jmp exit
exit:
    mov AL, 0
    mov AH, 4ch
    int 21h

xchange_all_simbols proc
; input bx
; output bx
    mov ax, len
    mov cl, 2
    div cl
    mov cl, al
    m1:
        mov si, cx ; первая половина
        
        mov ax, len
        sub ax, si
        mov di, ax ; вторая половина

        dec si
        xor ax, ax
        mov al, [bx+si]
        xchg al, [bx+di]    
        mov [bx+si], al
    loop m1
    ret
xchange_all_simbols endp

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