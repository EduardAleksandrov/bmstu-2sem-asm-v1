; Вычисление факториала из лекций (сделано на лабораторной) - работает
SS1 Segment para stack 'stack'
	dw 64 dup(0)
SS1 ends

sd1 Segment para 'data'
	n0 dw 4
	f dw ?
	str db 'start$'
sd1 ends

sc1 Segment para 'code'
	assume cs:sc1, ds:sd1, ss:ss1

fact proc near
	push bp
	mov bp, sp
	n equ [bp+4]
	mov cx, n
	dec cx
	jne m1
	mov ax, 1
	pop bp
	ret
	m1: 
		push cx
		call fact
		add sp, 2
		mov cx, n
		mul cx
		pop bp
		ret
fact endp
start proc
	mov ax, sd1
	mov ds, ax
	push n0
	call fact
	pop bx
	mov f, ax
	
	mov dx, offset str
	mov ah, 09h
	int 21h
	
	
	
	mov ah, 4ch
	int 21h
start endp
sc1 ends
	end start
	