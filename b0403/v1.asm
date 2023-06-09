; нарисовать прямоугольник - работает
text segment 'code'             ;(1) начало сегмента команд
    assume CS:text    ;(2)
vertical proc            ;(3) объявление процедуры построения вертикальной линии
v:	                        ;(4)    
	push CX              ;(5) сохраним в стек счетчик цикла
	mov	AH,0Ch          ;(6) функция вывода пикселя
	mov	AL,6            ;(7) установка цвета
	mov	BH,0            ;(8) видеостраница
	mov	CX,SI           ;(9) установка X-координаты
	int	10h             ;(10) вызов BIOS
	inc	DX              ;(11) счетчик Y-координаты 
	pop	CX              ;(12) выгрузим из стека счетчик цикла
	loop v               ;(13) меньшим его на единицу
ret                             ;(14) выход из подпрограммы
vertical endp            ;(15) конец текста подпрограммы
horizontal proc            ;(16) объявление процедуры построения горизонтальной линии
h:	                        ;(17)
	push CX              ;(18) сохраним в стек счетчик цикла
	mov	AH,0Ch          ;(19) функция вывода пикселя
	mov	AL,6            ;(20) установка цвета
	mov	BH,0            ;(21) видеостраница
	mov	CX,SI           ;(22) установка X-координаты
	int	10h             ;(23) вызов BIOS
	inc	SI              ;(24) счетчик Х-координаты
	pop	CX              ;(25) выгрузим из стека счетчик цикла
	loop	h               ;(26) уменьшим его на единицу
ret                             ;(27) выход из подпрограммы
horizontal endp            ;(28) конец текста подпрограммы

begin:	                        ;(29) начало основной программы
    mov	AX,00h                  ;(30) функция задания режима
	mov	AL,10h          ;(31) графический режим EGA
	int	10h             ;(32) вызов BIOS
	
    mov	SI,300          ;(33) Х-координата
	mov	DX,110          ;(34) Y-координата
	mov	CX,50           ;(35) длина стороны
	call vertical        ;(36) вызов подпрограммы
	
    mov	SI,300          ;(37) Х-координата
	mov	DX,110          ;(38) Y-координата
	mov	CX,100          ;(39) длина стороны
	call horizontal      ;(40) вызов подпрограммы

    mov	SI,400          ;(33) Х-координата
	mov	DX,110          ;(34) Y-координата
	mov	CX,50           ;(35) длина стороны
	call vertical 

    mov	SI,300          ;(33) Х-координата
	mov	DX,160          ;(34) Y-координата
	mov	CX,100           ;(35) длина стороны
	call horizontal 

	mov	AX,4C00h        ;(41) завершение программы
	int	21h             ;(42)
text ends                    ;(43) конец сегмента команд
end begin                   ;(44) конец текста программы