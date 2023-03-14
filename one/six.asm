data segment
    a db 5
    b db 4
    rez db 0
data ends
 
code segment
start:
    assume cs:code, ds:data
    mov ax, data
    mov ds, ax
    
    mov bl, a
    add bl, b
    mov rez, bl
    
    mov ah, 02
    mov dl, rez
    int 21h
    
    mov ax, 4c00h
    int 21h
code ends
end start