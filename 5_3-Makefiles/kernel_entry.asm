; Ensures that we jump straight into the kernel's entry function.
[bits 32]       ; We're in protected mode by now, so use 32-bit instructions.
[extern main]   ; Declare that we will be referncing the external symbol 'main'.
                ; so the linker can substitute the final address

    call main   ; invoke main() in our C kernel
    jmp $       ; Hang forever when we return from the kernel


; Raw binary format won't work in this case, since we need to have the main label resolved.
; We must output in the format of 'ELF (Executable and Linking Format)', 
; which is the default format outputted by our C compiler. 

; nasm -f elf kernel_entry.asm -o kernel_entry.o

; We can then link the kernel file with this kernel entry output file

; ld -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o --oformat binary

; The linker respects the order of the files we gave to it, the previous command
; will ensure our kernel_entry.o will precede the code in kernel.o

; Then we can reconstruct our kernel image file with the following command:
; cat boot_sect.bin kernel.bin > os-image
