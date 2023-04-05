; перевод из числа в строку - работает

Data SEGMENT

    _buffersize equ 10 ; размер строки
    _buffer db _buffersize dup(?) ; сюда заносится строка

Data ENDS

Ourstack SEGMENT Stack
    db 100h DUP (?)
Ourstack ENDS

Code SEGMENT
    ASSUME CS:Code, DS:Data, SS:Ourstack
start:
    mov AX, Data
    mov DS, AX

    mov ax, 57016 ; число для преобразования
    mov bx, offset _buffer
    mov cx, _buffersize

    call num_to_string

; печать строки
    call print_str
; ---

    jmp exit
exit:
    mov AL, 0
    mov AH, 4ch
    int 21h


num_to_string proc; печать цифр
; input
; ax = number
; bx = buffer
; cx = buffersize
; output
; _buffer = string
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    mov si, cx
    xor cx, cx
    next:
        push bx
        mov bx, 10
        xor dx, dx
        div bx
        pop bx
        add dx, '0' ; число в строку
        push dx
        inc cx
        
        cmp ax, 0
        je next_step

        jmp next

    next_step:
        mov dx, cx
        xor cx, cx
    to_str:
        cmp cx, si
        je pop_iter
        cmp cx, dx
        je close
        
        pop ax
        mov di, cx
        mov [bx+di], ax

        inc cx
        jmp to_str
    pop_iter:
        cmp cx, dx
        je close
        pop ax
        inc cx
        jmp pop_iter
    close:
        mov al, '$'
        mov [bx+si], al ; помещаем символ конца строки
        pop di
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
        ret
num_to_string endp

print_str proc; печать пустой строки
; input
; ax = char
    push ax
    push bx
    push cx
    push dx

    mov AH, 09h
    mov DX, OFFSET _buffer
    int 21h

    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_str endp
Code ENDS
END Start