.text
.globl _main
_main:
	#Intialize Registers
	lis r3,initRegisters@ha
	addi r3,r3,initRegisters@l
	mtlr r3
	blrl

	#This is our position
	lis r30,mdszMain@ha
	addi r30,r30,mdszMain@l

	#Get memory positon of patches.bin
	lis r29,_patches@ha
	addi r29,r29,_patches@l
	#Add our memory offset
	add r29,r29,r30
	#Get number of patches
	lwz r28,0(r29)
	#Set loop to run once per package
	mtctr r28
	#Move forward 4 bytes in patches.bin to the first patch's subheader
	addi r29,r29,4
	#The loop itself
	_patchLoop:
		#Get address to override
		lwz r3,0(r29)
		#Move forward 4 bytes to patch size
		addi r29,r29,4
		#Read patch size
		lwz r5,0(r29)
		#Move forward 4 bytes to patch
		addi r29,r29,4
		#Store r29 (patch start) in r4
		mr r4, r29
		#Move forward past the patch to the subheader of the next patch
		add r29,r29,r5;
		#Call memcpy
		lis r12,memcpy@h
		ori r12,r12,memcpy@l
		mtlr r12
		blrl
		#Loop
		bdnz _patchLoop

	#Go to original entry point
	lis r3,origEntry@ha
	addi r3,r3,origEntry@l
	mtlr r3
	blrl

#Include patches
_patches:
	.include "src/patches.s"
_endPatches:
