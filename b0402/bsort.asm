finish macro
	mov ax, 4c00h
	int 21h
endm
initds macro
	mov ax, dseg
	mov ds, ax
endm
dseg Segment
	str_arr db "9372658$"
dseg ends
cseg Segment
	assume cs:cseg, ds:dseg, ss:sseg
begin:
	initds
	mov cx, 6
	m0:
		push cx
		mov si, 6
	m1:
		mov ah, str_arr[si]
		cmp str_arr[si-1], ah
		jb m2
		mov al, str_arr[si]
		xchg al, str_arr[si-1]
		mov str_arr[si], al
	m2:
		dec si
		loop m1
		pop cx
		loop m0
		
		mov ah, 09h
		mov dx, offset str_arr
		int 21h
		finish
cseg ends
sseg Segment
	dw 64 dup(0)
sseg ends
	end begin