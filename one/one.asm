.286
.model small
.code
start: MOV AX,123h   ; записать 0123 в AX
    ADD AX, 25h   ; прибавить 25 к AX
    MOV BX, AX      ;
    SUB CX, AX      ;
    SUB AX, AX
     mov ah,4Ch
     int 21h
end start
