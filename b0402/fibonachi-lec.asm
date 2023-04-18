; фибоначчи рекурсия с лекции  - работает

Data SEGMENT
    empty db ?, 13, 10 , "$" ; пустая строка
    var db 6
Data ENDS

Ourstack SEGMENT Stack
    db 100h DUP (?)
Ourstack ENDS

Code SEGMENT
    ASSUME CS:Code, DS:Data, SS:Ourstack
Start:
    mov AX, Data
    mov DS, AX

    xor ax, ax
    mov al, var
    call rec_fib
    mov ax, bx
    call print_num

    jmp exit
exit:
    mov AL, 0
    mov AH, 4ch
    int 21h

rec_fib proc
; input - al
; output - bx
    cmp al, 1
    ja f1
    mov bx, 1
    ret
    f1:
        push ax
        dec al
        call rec_fib
        push bx
        dec al
        call rec_fib
        pop ax
        add bx, ax
        pop ax
        ret
rec_fib endp


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