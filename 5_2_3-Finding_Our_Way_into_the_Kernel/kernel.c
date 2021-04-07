// Example of kernel code that would cause issues, since we are calling the first instruction of the
// machine code, which isn't always the main entry point, such as below

void some_function() {
}

void main() {
    char *video_memory = 0xb8000;
    *video_memory = 'X';
    // Call some function
    some_function();
}

// If we begin execution from the first instruction in this code but compiled, we would return to the boot sector
// from the first ret instruction in 'some_function()'
