; проверка элементов массива - работает
DSEG Segment
    nmax dw 6
    n dw 6
    x db '123456'
      db '123456'
      db '123456'
      db '123456'
      db '123456'
      db '123456'
DSEG ENDS

CSEG Segment
ASSUME CS:CSEG, DS:DSEG, SS:SSEG
START:
    mov ax, DSEG
    mov ds, ax

    mov si, 2

    mov AH, 02h
    mov dl, x[si]
    int 21h


    ; mov si, 36
    ; mov cl, '$'
    ; mov BX, OFFSET x
    ; mov [BX+SI], cl

    ; mov AH, 09h
    ; mov DX, OFFSET x
    ; int 21h



    mov ah, 4ch
    int 21h
CSEG ENDS

SSEG Segment Stack
    dw 64 dup(0)
SSEG ENDS
    END START
