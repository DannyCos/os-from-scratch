;
; Example of function calls
;   

; Very basic funciton call. 
    
    mov al, 'H'     ; Store H into al for our function to print it
    jmp my_print_function

return_to_here:     ; This label allows us to return back
    ; ...
    ; ...

my_print_function:
    mov ah, 0x0e    ; int = 10/ah = 0eh -> BIOS tele-type output
    int 0x10
    jmp return_to_here


; Main flaw with this is the need for the return label, we need to explicitly say where to return to after
; the function call, it would not be possible to call this function from arbitrary points in the program.
; We could store the correct return address (i.e. the return address after the call) in some well-known location,
; then the called code could jump back to that stored address. The CPU keeps track of the current instruction being ; executed in the special register ip (instruction pointer), which cannot be accessed directly. However, the CPU
; provides a pair of instructions, call and ret, which do exactly hat we want. Call behaves like jmp, but 
; additionally, pushes the return address onto the stack, ret then pops the return address and jumps to it.

    mov al, 'H'
    call my_print_function

my_print_function:
    mov ah, 0x0e
    int 0x10
    ret

; One more problem that must be addressed, the value of the registers can be altered by the function, it would
; be ideal if we could store them before the function, and then restore the registers. Storing them on the stack
; for example. Two CPU has two instructions to do exactly that. pusha - pushes all registers onto the stack,
; and popa - pops all registers from the stack.

    mov al, 'H'
    call some_function

some_function:
    pusha
    mov bx, 10
    add bx, 20
    mov ah, 0x0e
    int 0x10
    popa
    ret
;
