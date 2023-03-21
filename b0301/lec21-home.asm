; Нахождение второго четного элемента, ноль является четным

DSEG SEGMENT PARA PUBLIC 'DATA'
    array dw 3,1,1,3,4,5,6,7
    b dw 1b
    k dw ?
    zero dw 0b
DSEG ENDS

SSTACK SEGMENT PARA STACK 'STACK'
    db 64 DUP (?)
SSTACK ENDS


CSEG SEGMENT PUBLIC 'CODE'
    ASSUME CS:CSEG, DS:DSEG, SS:SSTACK
print_result proc ; печать результата
    mov ah, 2h
    mov dx, bx
    add dx, '0'
    int 21h
    ret
print_result endp

START:
    mov ax, DSEG
    mov ds, ax

m1:
    mov k, 2
    mov si, offset array
    mov cx, 8
    mov ax, b

m2:
    test [si], ax
    jnz m3
    dec k
    
    mov bx, k
    cmp zero, bx
    je m4
    jz m3

m3:
    add si, 2
    loop m2

m4:
    xor bx, bx
    mov bx, [si]
    call print_result
    jmp exit

exit:
    mov AL, 0
    mov AH, 4ch
    int 21h
CSEG ENDS
    END START