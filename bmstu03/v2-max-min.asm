Data SEGMENT
    org 0100h ;смещение от начала базы сегмента
    greet dw 1
    array dw 1,2,3,4,5
Data ENDS

Ourstack SEGMENT Stack
    db 100h DUP (?)
Ourstack ENDS

ASSUME CS:Code, DS:Data, SS:Ourstack

Code SEGMENT
print_str proc
    mov ah, 2h
    mov dx, bx
    add dx, '0'
    int 21h
    ret
print_str endp

Start:
    mov AX, Data
    mov DS, AX

;max
    mov si, offset array   ; либо si = 0 и везде вместо [si] пишем array[si]
    mov cx, 5
    xor bx, bx
m1: 
    cmp [si], bx
    jg max
    jmp m2
max:
    mov bx, [si]
m2:
    add si, 2
    loop m1

    call print_str
;min
    mov si, offset array
    mov cx, 5
    mov bx, [si]
m3: 
    cmp [si], bx
    jl min
    jmp m4
min:
    mov bx, [si]
m4:
    add si, 2
    loop m3
    
    call print_str

    jmp exit
    
exit:
    mov AL, 0
    mov AH, 4ch
    int 21h
Code ENDS
END Start