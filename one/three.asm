stk segment stack
    DW 32 dup(?)
stk ends
cds     segment
    assume cs:cds,ss:stk
    main proc far
        mov ah,02
        mov dl, 'A'
        int 21h

        mov ah,01
        int 21h

        mov ah,4ch
        int 21h
    main endp
cds ends
END main