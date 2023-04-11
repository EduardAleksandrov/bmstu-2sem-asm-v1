; Факториал через рекурсию - работает

Data SEGMENT
    empty db ?, 13, 10 , "$" ; пустая строка
    var dw 5
Data ENDS

Ourstack SEGMENT Stack
    db 100h DUP (?)
Ourstack ENDS

Code SEGMENT
    ASSUME CS:Code, DS:Data, SS:Ourstack
Start:
    mov AX, Data
    mov DS, AX

    mov ax, var
    call rec_fac
    call print_num

    jmp exit
exit:
    mov AL, 0
    mov AH, 4ch
    int 21h

rec_fac proc
    push ax
    dec ax
    cmp ax, 0
    jne m1
    
    mov ax, 1
    pop cx
    mul cx
    
    ret
    m1: 
        call rec_fac
        pop cx
        mul cx
        ret
rec_fac endp



factorial proc
; input - ax - number
; output - ax - number
    push bx
    mov bx, ax
    mov ax, 1
    next_iter_f:
        cmp bx, 1
        jle close_f
        mul bx
        dec bx
        jmp next_iter_f
    close_f:
    pop bx
    ret
factorial endp


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