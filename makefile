all: clean mkdd-patched.iso

#Patched game disk
mkdd-patched.iso: GM4E01 bin/main.bin
	#Patch the game's executable
	wit dolpatch GM4E01/boot.dol new=text,auto load=803F0000,bin/main.bin entry=803F0000
	#repack the game
	gcdx create $< $@

#Extracted game directory
GM4E01: mkdd.iso
	gcdx extract $<

bin:
	mkdir $@

clean:
	rm -rf GM4E01 bin mkdd-patched.iso

#Run the patched ISO in dolphin
test: mkdd-patched.iso
ifeq ($(OS),Windows_NT)
	#Dolphin uses /s instead of -s on Windows
	dolphin /d /e mkdd-patched.iso
else
	#Dolphin is usually named dolphin-emu on Linux to avoid confusion with the dolphin file manager
	dolphin-emu -d -e mkdd-patched.iso
endif

include src/makefile
