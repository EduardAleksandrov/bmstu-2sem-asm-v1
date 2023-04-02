; процедуры в конце программы - работает

Data SEGMENT
    org 0100h ;смещение от начала базы сегмента
    empty db ?, 13, 10 , "$" ; пустая строка
    num dw 3 ; число
Data ENDS

Ourstack SEGMENT Stack
    db 100h DUP (?)
Ourstack ENDS

Code SEGMENT
    ASSUME CS:Code, DS:Data, SS:Ourstack
start:
    mov AX, Data
    mov DS, AX

    mov dx, num
    mov cx, num
m1:
    push dx
    dec dx
    loop m1

    xor ax, ax
    xor dx, dx
    mov ax, 1
    mov cx, num
m2: 
    pop dx
    mul dx   ; результат кладется в ax
    loop m2

; печать цифры
    call print_num
    call print_empty
; ---

    jmp exit
exit:
    mov AL, 0
    mov AH, 4ch
    int 21h

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

Code ENDS
END Start