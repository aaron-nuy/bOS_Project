bin/boot.bin: temp/full_kernel.bin temp/boot_sector.bin
	copy /b temp/boot_sector.bin+temp/full_kernel.bin bin/boot.bin

temp/boot_sector.bin: asm/boot_sector.asm
	nasm asm/boot_sector.asm -o temp/boot_sector.bin

temp/full_kernel.bin: temp/kernel_entry.o temp/kernel.o
	ld -T NUL -o temp/kernel.tmp -mi386pe -Ttext 0x1000 temp/kernel_entry.o temp/kernel.o 
	objcopy -O binary -j .text  temp/kernel.tmp temp/full_kernel.bin

temp/kernel_entry.o: asm/kernel_entry.asm
	nasm asm/kernel_entry.asm -f elf32 -o temp/kernel_entry.o

temp/kernel.o: cpp/kernel.cpp
	g++ -ffreestanding -mno-red-zone -m32 -c cpp/kernel.cpp -o temp/kernel.o