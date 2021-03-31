// We can compile this into an object file without linking with
// gcc -ffreestanding -c basic.c -o basic.o
// Inspect the objects file contents with
// objdump -d basic.o
// output raw machine code into a bin file with
// ld -o basic.bin -Ttext 0x0 --oformat binary basic.o
// Disassemble bin file into assmebly using
// ndisasm -b 32 basic.bin > basic.dis
int my_function() {
  return 0xbaba;
}
