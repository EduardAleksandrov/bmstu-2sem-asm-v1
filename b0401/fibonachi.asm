; 

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
    call rec_fib
    call print_num

    jmp exit
exit:
    mov AL, 0
    mov AH, 4ch
    int 21h

rec_fib proc
    
    cmp ax, 1
    jbe done
    sub si, 4
    dec ax
    mov [si], ax
    call rec_fib
    mov [si+2], ax
    mov ax, [si]
    dec ax
    call rec_fib
    add ax, [si+2]
    add si, 4
    done:
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