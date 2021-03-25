	cmp ax, 4	; Compare the value in ax to 4
	je then_block	; jump to then_block if they were equal
	mov bx, 45	; otherwise, execute this code
	jmp the_end	; important: jump over the 'then_block' so we don't also execute that code

then_block:
	mov bx, 24
the_end:
; ...


; Jump instructions:
; je 	jump if equal
; jne 	jump if not equal
; jl	jump if less than
; jle 	jump if less than or equal
; jg	jump if greater than
; jge	jump if greater than or equal

