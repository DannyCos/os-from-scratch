; load DH sectors to ES:BX from drive DL
disk_load:
    push dx             ; Store DX on stack so later we can recall how many sectors
                        ; were requested to be read, even if it is altered in the meantime

    mov ah, 0x02        ; BIOS read sector function
    mov al, dh          ; Read DH sectors
    mov ch, 0x00        ; Select cylinder 0
    mov dh, 0x00        ; Select head 0
    mov cl, 0x02        ; Start reading from second sector (i.e. after the boot sector)
    
    int 0x13            ; BIOS Interrupt

    jc disk_error       ; Jump if error (i.e. carry flag set)

    pop dx              ; Restore DX from the stack
    cmp dh, al          ; if AL (sectors read) != DH (sectors expected)
    jne disk_error      ; Display error message
    ret

disk_error: 
    mov bx, DISK_ERROR_MSG
    call print_string
    mov dh, ah          ; ah = error code, dl = disk drive that dropped the error
    call print_hex
    jmp $

sector_error:
    mov bx, SECTOR_ERROR_MSG
    call print_string
    jmp $

DISK_ERROR_MSG: db "Disk read error!", 0
SECTOR_ERROR_MSG: db "Sector error!", 0