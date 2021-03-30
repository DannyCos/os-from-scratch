print_string:
    pusha           ; Push all registers onto stack
    mov ah, 0x0e    ; int 10 / ah = 0x0e -> Tele-type BIOS print

print_char:
    mov al, [bx]    ; Set al to the value at address bx (first char of word)
    cmp al, 0       ; Compare that value to 0
    je print_string_end          ; If that value was 0, jump to end label
    int 0x10        ; print char on al
    add bx, 0x1     ; add 0x1 to bx, moving the address up to the next char.
    jmp print_char  ; Jump back to print_char label, to redo the steps above

print_string_end:
    popa            ; Pop all values from stack into registers.
    ret             ; Return to address after function call.
