;
; A simple boot sector program that demonstrates addressing.
; (Note: Boot sector is loaded into memory at address 0x7c00 -> 0x7e00 (512 bytes))

; org 0x7c00

mov ah, 0x0e		; int 10/ah = 0eh -> scrolling teletype BIOS routine

; First attempt
mov al, the_secret
int 0x10		; Does this print an X?
			; This fails as we load the address offset into al (0x1d)

; Second attempt
mov al, [the_secret]
int 0x10		; Does this print an X?
			; This fails as it stores the content at offset 0x1d, but offset from 0x0. (Somewhere in the interrupt vector)

; Third attempt
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10		; Does this print an X?
			; This succeeds, as it first stores the offset into bx, adds the offset for the boot sector address and then retrieves the value at that offset (0x7c1d).
			; Note. We can account for this offset by adding (org 0x7c00) at the start of our code.

; Fourth attempt
mov al, [0x7c1d]
int 0x10		; Does this print an X?
			; This succeeds, for the same reason as the one above, only without using the_secret address, and instead hardcoding the address.

jmp $			; Jump forever

the_secret:
	db "X"

; Padding and magic BIOS number

times 510-($-$$) db 0
dw 0xaa55
