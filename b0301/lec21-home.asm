DSEG SEGMENT PARA PUBLIC 'DATA'
    x db 0,1,2,3,4,5,6,7
    b db 1b
    k db ?
DSEG ENDS

SSTACK SEGMENT PARA STACK 'STACK'
    db 64 DUP (?)
SSTACK ENDS


CSEG SEGMENT PUBLIC 'CODE'
    ASSUME CS:CSEG, DS:DSEG, SS:SSTACK
START PROC FAR
    mov ax, DSEG
    mov ds, ax
    m1: mov k, 2
        mov si, 0
        mov cx, 8
        mov al, b
    m2: TEST x[si], al
        JNZ m3
        DEC k
        JZ m4
    m3: inc si
        loop m2
    m4: add si, '0'
        mov ah, 2h
        mov dx, si
    m5: int 21h
    m6: mov ah, 4ch
        mov al, 0
        int 21h
START ENDP
CSEG ENDS
    END START