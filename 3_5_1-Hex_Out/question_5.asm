;
; Print a hex value out as a string
;

[org 0x7c00]

mov dx, 0x7e89
call print_hex

jmp $

; Prints the value of DX as hex.
print_hex:
    pusha
    mov cx, 0   ; index 0
    
loop:
    cmp cx, 4
    je hex_end

    mov ax, dx      ; move dx into ax
    shr ax, cl      ; shift right by index
    and ax, 0x000f  ; and to get last digit only
    add al, 0x30    ; add 0x30 to convert to digit
    cmp al, 0x39    ; if greater than '9', add extra 0x27 to represent character
    jle skip
    add al, 0x27

skip:
    mov bx, HEX_OUT + 0x5   ; set bx to last value of hex_out (not null char)
    sub bx, cx              ; move back by the index amount
    mov [bx], al            ; set value at bx address to ax
    shr dx, 3               ; shift dx right 4 bits to set the next digit as the last digit

    add cx, 1 
    jmp loop

hex_end:
    mov bx, HEX_OUT
    call print_string
    popa
    ret

HEX_OUT: db '0x0000',0

%include "print_string.asm"

    times 510-($-$$) db 0
    dw 0xaa55
