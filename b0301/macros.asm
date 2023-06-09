; task: нахождение максимума и минимума в массиве используя макросы

Data SEGMENT
    org 0100h ;смещение от начала базы сегмента
    greet db ' ', 13, 10 , "$" ; пустая строка
    array dw 1,2,3,4,5
Data ENDS

Ourstack SEGMENT Stack
    db 100h DUP (?)
Ourstack ENDS

ASSUME CS:Code, DS:Data, SS:Ourstack

Code SEGMENT
printr MACRO ; результат в цифровом виде, входящее значение в bx
    mov ah, 2h
    mov dx, bx
    add dx, '0' ; преобразовываем цифру в ASCII символ
    int 21h
endm

empty MACRO ; пустая строка
    mov AH, 09h
    mov DX, OFFSET greet
    int 21h
endm

Start:
    mov AX, Data
    mov DS, AX

;max
    mov si, offset array   ; либо si = 0 и везде вместо [si] пишем array[si]
    mov cx, 5
    xor bx, bx
m1: 
    cmp [si], bx
    jg max ; проверяет флаги ZF, SF и OF. Переход выполняется, если ZF = 0 и SF = OF
    jmp m2
max:
    mov bx, [si]
m2:
    add si, 2
    loop m1

    printr
    empty
;min
    mov si, offset array
    mov cx, 5
    mov bx, [si]
m3: 
    cmp [si], bx
    jl min ; проверяет флаги SF и OF. Переход выполняется, если SF не равен OF
    jmp m4
min:
    mov bx, [si]
m4:
    add si, 2
    loop m3
    
    printr

    jmp exit
    
exit:
    mov AL, 0
    mov AH, 4ch
    int 21h
Code ENDS
END Start