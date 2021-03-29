    mov ah, 0x02    ; BIOS read sector function

    mov dl, 0       ; Read drive 0 (i.e. first floppy drive)
    mov ch, 3       ; Select cylinder 3
    mov dh, 1       ; Select the track on 2nd side of floppy disk, since this count has a base of 0

    mov cl, 4       ; Select the 4th sector on the track - not 5th, since this has a base of 1.
    mov al, 5       ; Read 5 sectors from the start point

    ; Lastly, set the address that we'd like the BIOS to read the sectors to, which BIOS expects to find in ES:BX
    ; (i.e. segemnt ES with offset BX).

    mov bx, 0xa000  ; Indirectly set ES to 0xa000
    mov es, bx
    mov bx, 0x1234
    ; In our case, data will be read to 0xa000:0x1234, which the cpu will translate to physical address 0xa1234

    int 0x13        ; Now issue the BIOS interrupt to do the actual read.

    jc disk_error   ; jc = Jump is carry flag was set.

    ; This jumps if what BIOS reported as the number of sectors actually read in AL is not equal to the number we expected.
    cmp al, 5
    jne disk_error

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

DISK_ERROR_MSG:
    db "Disk read error!", 0
