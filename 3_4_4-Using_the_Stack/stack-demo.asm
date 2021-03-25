;
; A simple boot sector program that demonstrates the stack.
;

mov ah, 0x0e	; int 10/ah = 0eh -> scrolling teletype BIOS routine.

mov bp, 0x8000 	; Set the base of the stack a little above where the BIOS loads our boot sector - so it won't overwrite us.
mov sp, bp	; bp = stack base, sp = stack top. When pushing a value, it gets stored below the address of bp, and sp is decremented by the value's size.

push 'A'	; Push some characters on the stack for later retrieval. Note, these are pushed on as 16-bit values,
push 'B'	; so the most significant byte will be added by our assembler as 0x00
push 'C'	;

pop bx		; Note, we can only pop 16-bits, so pop to box then copy bl (i.e. 8-bit char) to al
mov al, bl	;
int 0x10	; print al

pop bx		; Pop and print the next value
mov al, bl
int 0x10

mov al, [0x7ffe]	; To prove our stack grows downwards from bp, fetch the char at 0x8000 - 0x2 (i.e. 16-bits) 
int 0x10		; print(al).

jmp $			; Jump forever

; Padding and magic BIOS number
times 510-($-$$) db 0
dw 0xaa55
