all: os-image

boot.bin: boot.asm
	nasm -f bin boot.asm -o boot.bin

kernel.bin: kernel.c
	i386-elf-gcc -ffreestanding -m32 -c kernel.c -o kernel.o
	i386-elf-ld -T linker.ld -o kernel.bin kernel.o --oformat binary

os-image: boot.bin kernel.bin
	cat boot.bin kernel.bin > os-image

run: os-image
	qemu-system-i386 -fda os-image

clean:
	rm -f *.bin *.o os-image
