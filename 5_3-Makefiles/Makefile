all : os-image

# This is the actual disk image that the computer loads,
# which is the combination of our compiled bootsector and kernel
os-image : boot_sect.bin kernel.bin
	cat $^ > os-image

# This builds the binary of our kernel from two object files:
# 	- the kernel_entry, which jumps to main() in our kernel
# 	- the compiled C kernel
#
# $^ is substituted with all of the target's dependancy files
kernel.bin : kernel_entry.o kernel.o
	ld -Ttext 0x1000 --oformat binary -m elf_i386 -s -o $@ $^

# Build our kernel object file
#
# $< is the first dependancy and $@ is the target file
kernel.o : kernel.c
	gcc -fno-pie -m32 -ffreestanding -c $< -o $@

# Buld our kernel entry object file
#
# Same rules as above
kernel_entry.o : kernel_entry.asm
	nasm $< -f elf -o $@

# Assemble the boot sector to raw machine code
# 	The -I options tells nasm where to find our routines
# 	that we included in boot_sect.asm
boot_sect.bin : boot_sect.asm
	nasm $< -f bin -o $@

# Clean the directory of generated files
clean :
	rm -rf *.bin *.o *.dis os-image *.map

# Run qemu to simulate booting of code
run : all
	qemu-system-x86_64 os-image

# Disassemble our kernel - useful for debugging (possibly)
kernel.dis : kernel.bin
	ndisasm -b 32 $< > $@
