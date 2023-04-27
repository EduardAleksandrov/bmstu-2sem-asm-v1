; перевод из строки в число (через сравнение с длиной строки) - работает

; '531', $
; '5' - '0' = 5
; '3' - '0' = 3
; '1' - '0' = 1

; 1*1 + 3*10 + 5*100 = 531

Data SEGMENT
    org 0100h ;смещение от начала базы сегмента
    empty db ?, 13, 10 , "$" ; пустая строка
    num db '53123', "$" ; число
    numlen = $-num-1 ; длина строки num
    multi dw 10 ; умножение на 10 плюс сумма
Data ENDS

Ourstack SEGMENT Stack
    db 100h DUP (?)
Ourstack ENDS

Code SEGMENT
    ASSUME CS:Code, DS:Data, SS:Ourstack

start:
    mov AX, Data
    mov DS, AX

    xor ah, ah
    mov bx, offset num
    call string_to_number

    mov ax, bx
; печать цифры
    ;call print_char
    call print_num
    call print_empty
; ---

    jmp exit
exit:
    mov AL, 0
    mov AH, 4ch
    int 21h

string_to_number proc
; input bx = string
; output bx = number
    push ax
    push cx
    push dx
    push si

    xor ax, ax
    xor cx, cx

    mov cx, numlen ;счетчик
    ;mov ax, '$'
    next_iter:
            ;cmp [bx+si], ax
            ;je next_step
            mov al, [bx+si]
            sub al, '0' ; перевод символа в число
            push ax
            inc si
            loop next_iter
            ;jmp next_iter
    next_step:
            mov cx, 1
            xor bx, bx
            xor ax, ax
    to_number:
            cmp si, 0
            je close_p
            pop ax

            mul cx
            add bx, ax
            mov ax, cx
            
            mul multi
            mov cx, ax

            dec si
            jmp to_number
    close_p:
    pop si
    pop dx
    pop cx
    pop ax
    ret
string_to_number endp

print_char proc; печать символа
; input
; ax = char
    push ax
    push bx
    push cx
    push dx

    ; mov symbol, al
    mov AH, 09h
    mov DX, OFFSET num
    int 21h

    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_char endp

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
        add dx, '0' ; перевод числа в символ
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