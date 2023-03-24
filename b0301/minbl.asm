; task: нахождение максимума в массиве через bl (db)

Data SEGMENT
    array db 4,2,1,9,5
Data ENDS

Ourstack SEGMENT Stack
    db 100h DUP (?)
Ourstack ENDS

Code SEGMENT
    ASSUME CS:Code, DS:Data, SS:Ourstack
Start:
    mov AX, Data
    mov DS, AX

;max
    mov si, 0   
    mov cx, 4
    mov bl, array[si]
m1: 
    inc si
    mov al, array[si]
    cmp al, bl
    jl min ; проверяет флаги ZF, SF и OF. Переход выполняется, если ZF = 0 и SF = OF
    jmp m2
min:
    mov bl, array[si]
m2:
    loop m1

prt:
    mov ah, 2h
    mov dx, bx
    add dx, '0' ; преобразовываем цифру в ASCII символ
    int 21h
    
exit:
    mov AL, 0
    mov AH, 4ch
    int 21h
Code ENDS
END Start