; In 32 bit protected mode, we cannot use BIOS routines.
; The screen is a visual representation of a specific range of memory (starting from 0xb8000). 
; Most computers boot into a simple Video Graphics Array colour text mode with dimensions 80x25 character. (Screens can be in one of two modes, text mode and graphics mode.)
; In text mode, we do not need to render invidivual pixels to describe specific character, since a simple font is already defined
; in the internal memory of the VGA display device. Instead, each character cell is represented by 2 bytes in memory. The first is the ascii code,
; the second encodes the character attributes, such as the foreground and background colour, and if the character should be blinking.
; Video memory is sequential, rows and columns are represented as such in memory: 0xb8000 + 2 * (row * 80 + col)

[bits 32]
; Define some constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; prints a null-terminated string pointed to by EBX
print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY       ; Set edx to the start of video memory

print_string_pm_loop:
    mov al, [ebx]               ; Store tha char at EBX in al
    mov ah, WHITE_ON_BLACK      ; Store the attributes in ah

    cmp al, 0                   ; if al == 0, at end of string, jump  to done
    je print_string_pm_done     

    mov [edx], ax               ; Store char and attributes at current character cell

    add ebx, 1                  ; Increment EBX to the next char in the string
    add edx, 2                  ; Move to the next character cell in video memory

    jmp print_string_pm_loop    ; Loop around to print the next character

print_string_pm_done:
    popa
    ret                         ; Return from the function
