; task: нахождение максимума и минимума в массиве v3, через bl, готовая

Data SEGMENT
    org 0100h ;смещение от начала базы сегмента
    greet db ' ', 13, 10 , "$" ; пустая строка
    array db 1,2,3,4,5
Data ENDS

Ourstack SEGMENT Stack
    db 100h DUP (?)
Ourstack ENDS

ASSUME CS:Code, DS:Data, SS:Ourstack

Code SEGMENT
print_result proc ; результат в цифровом виде, входящее значение в bx
    mov ah, 2h
    mov dx, bx
    add dx, '0' ; преобразовываем цифру в ASCII символ
    int 21h
    ret
print_result endp

print_empty proc ; пустая строка
    mov AH, 09h
    mov DX, OFFSET greet
    int 21h
    ret
print_empty endp

Start:
    mov AX, Data
    mov DS, AX

;max
    mov si, offset array   ; либо si = 0 и везде вместо [si] пишем array[si]
    mov cx, 5
    mov bl, [si]
m1: 
    cmp [si], bl
    jg max ; проверяет флаги ZF, SF и OF. Переход выполняется, если ZF = 0 и SF = OF
    jmp m2
max:
    mov bl, [si]
m2:
    add si, 1
    loop m1

    call print_result
    call print_empty
;min
    mov si, offset array
    mov cx, 5
    mov bl, [si]
m3: 
    cmp [si], bl
    jl min ; проверяет флаги SF и OF. Переход выполняется, если SF не равен OF
    jmp m4
min:
    mov bl, [si]
m4:
    add si, 1
    loop m3
    
    call print_result

    jmp exit
    
exit:
    mov AL, 0
    mov AH, 4ch
    int 21h
Code ENDS
END Start