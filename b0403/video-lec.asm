;вывод текста в видео режиме с лекции - работает
ASSUME cs:code, ds:code
code Segment
    org 100h
start:
    mov ax, cs
    mov ds, ax
;видеорежим
    mov ah, 0
    mov al, 3
    int 10h
;очистка экрана
    mov ax, 0b800h
    mov es, ax
    xor si, si
    xor di, di
    mov cx, 2000
    mov ax, 0700h
    rep stosw

;вывод текста
    lea si, str
    mov di, 2000
    mov ah, 8fh

    loopm2:
        cmp byte ptr[si], 0

        jz loop1

        mov al, [si]
        mov es:[di], ax
        inc si
        inc di
        inc di
        jmp short loopm2
    loop1:
        mov ah, 0
        int 16h
        cmp al, ' '
        jnz loop1
;выход
    int 20h
    str db 'blinking text', 0
code ENDS
    end start