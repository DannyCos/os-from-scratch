; Convert this psuedo-code block into assembly

; if (bx <=4) {
; 	mov al, 'A'
; } else if (bx < 40) {
; 	mov al, 'B'
; } else {
; 	mov al, 'C'
; }
	
	mov bx, 50

; Block starts here
	
	cmp bx, 4 	; compare bx to 4
	jle set_a	; jump to set_a if less than or equal
	cmp bx, 40	; other, compare bx to 40
	jl set_b	; jump to set_b if less than
	jmp set_c	; otherwise, jump to set_c
	
set_a:
	mov al, 'A'	; set al to 'A'
	jmp end		; jump to end to skip other code blocks
set_b:	
	mov al, 'B'	; set al to 'B'
	jmp end		; jump to end to skip other code blocks
set_c:
	mov al, 'C'	; set al to 'C', no need to jump to end, since no other instructions are in between set_c and end
end:

; Block ends here

	mov ah, 0x0e 	; int 10/ ah = 0eh -> BIOS tele-type output
	int 0x10	; print al

	jmp $		; infinite loop

; padding and magic number
	times 510-($-$$) db 0
	dw 0xaa55
