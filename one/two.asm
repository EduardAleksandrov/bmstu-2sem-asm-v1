PAGE 60,132
TITLE EXASM1 (EXE) Пример регистровых операций
;---------------------------------------------
STACKSG SEGMENT PARA STACK 'Stack'
    DB 12 DUP('STACKSEG')
STACKSG ENDS
;---------------------------------------------
CODESG SEGMENT PARA 'Code'
BEGIN PROC FAR
    ASSUME SS:STACKSG, CS:CODESG, DS:NOTHING
    PUSH DS         ; Записать DS в стек
    SUB AX, AX      ; Записать ноль
    PUSH AX         ; в стек
    MOV AX, 0123H   ; записать 0123 в AX
    ADD AX, 0025H   ; прибавить 25 к AX
    MOV BX, AX      ;
    SUB CX, AX      ;
    SUB AX, AX      ;
    NOP
    RET
BEGIN ENDP          ; конец процедуры
CODESG ENDS         ; конец сегмента
END BEGIN           ; конец программы