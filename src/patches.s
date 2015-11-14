#==========================
#         Header
#==========================
.int 3 #Number of patches TODO: Automate this
#==========================
#         Patches
#==========================
# Format:
# .int <injection address>
# .int <code length>
# <code>
#==========================
#Disables the start screen wallpaper from changing when everything is unlocked
#This is basically a test for the patch system
#.int patchTitle2Override_Entry #Address to override
#.int _endTitle2Override - _title2Override #Size of code
#_title2Override:
#	.asciz "title\0" #Replace "title2" with "title "
#_endTitle2Override:

#Allows the character select cursor to highlight any character on the character select screen.
#Ignores if the character has already been selected but still respects if the character isn't unlocked yet.
.int patchUnrestrictedCharacterCursor_Entry
.int _endUnrestrictedCharacterCursor - _unrestrictedCharacterCursor
_unrestrictedCharacterCursor:
	.int 0x480000A8; # b 80163A7C
_endUnrestrictedCharacterCursor:

#I just created 180 bytes of dead code in the last patch, lets use it to store this logic
#This adds a check when selecting a new passenger to make sure they do not match your selected driver
#For some reason if the driver and passenger are the same the game will crash
.int patchPreventDriverPassengerMatch_Entry
.int _endPreventDriverPassengerMatch - _preventDriverPassengerMatch
_preventDriverPassengerMatch:
	lis r16,patchPreventDriverPassengerMatch_Code@ha
	addi r16,r16,patchPreventDriverPassengerMatch_Code@l
	mtlr r16
	blr
_endPreventDriverPassengerMatch:

#See the description of the previous patch
.int patchPreventDriverPassengerMatch_Code
.int _endPreventDriverPassengerMatchCode - _preventDriverPassengerMatchCode
_preventDriverPassengerMatchCode:
	#Restore what we overwrote previously
	srawi     r0, r30, 1
	srwi      r3, r30, 31
	addze     r5, r0
	clrlwi    r0, r30, 31
	#Get the driver ID
	lwz       r16, 0x2138(r4)
	#Compare the passenger ID and driver ID
	cmpw r30, r16
	#If they match then skip over the storing code
	#Prepare to jump!
	lis r16,patchPreventDriverPassengerMatch_Entry@ha
	addi r16,r16,patchPreventDriverPassengerMatch_Entry@l
	addi r16, r16, 16
	bne __returnPreventDriverPassengerMatchCode
	#If they do match then adjust the branch to go to 0x80162CAC
	addi r16, r16, 0xA8
	__returnPreventDriverPassengerMatchCode:
		mtlr r16
		blr
_endPreventDriverPassengerMatchCode:
