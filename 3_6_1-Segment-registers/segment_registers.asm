;
; A simple boot sector program that demonstrates segment offsettings.
;

    mov ah, 0x0e            ; int 10 / ah = 0eh -> scrolling teletype BIOS routine

    mov al, [the_secret]    
    int 0x10                ; This will not print the 'X' as the value retrieved is not offset by the memory location that the boot sector was loaded into (0x7c00)

    mov bx, 0x7c0           ; Can't set ds (data segment) directly, so we first set bx
    mov ds, bx              ; copy bx to ds
    mov al, [the_secret]    ;
    int 0x10                ; This now works, since the data segment offsets the address of the_secret by the value 
                            ; we set it to multiplied by 16, so we have (16 * 0x7c0 + the_secret) as the address retrieved.
    
    mov al, [es:the_secret] ; We manually specify to use the es segment register instead.
    int 0x10                ; This does not print 'X' for the same reason as the first attempt

    mov bx, 0x7c0           ;
    mov es, bx              ;
    mov al, [es:the_secret] ;
    int 0x10                ; This works for the same reason as the second attempt, only the segment register is different.

    jmp $                   ; jump forever

the_secret:
    db "X"

    ; Padding and boot sector signature
    times 510 - ($-$$) db 0
    dw 0xaa55
