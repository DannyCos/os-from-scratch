;
; A boot sector that prints a string using our function.
;
[org 0x7c00]    ; Tells the assembler where this code will be loaded in memory.

    mov bx, HELLO_MSG   ; Use BX as a parameter to our function, so we can specify the address of a string.
    call print_string

    mov bx, GOODBYE_MSG
    call print_string

    jmp $               ; Loop

%include "print_string.asm"

;Data
HELLO_MSG:
    db 'Hello, World!',0
GOODBYE_MSG:
    db 'Goodbye!',0

    ; Padding and magic number
    times 510-($-$$) db 0
    dw 0xaa55
