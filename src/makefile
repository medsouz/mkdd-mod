bin/main.bin: bin/main.elf
	powerpc-eabi-objcopy -O binary -j .text $< $@

bin/main.elf: bin/main.o
	powerpc-eabi-ld -T src/GM4E01.ld $< -o $@

bin/main.o: src/main.s bin
	powerpc-eabi-as -mregnames $< -o $@
