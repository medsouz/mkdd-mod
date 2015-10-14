#==========================
#         Header
#==========================
.int 1 #Number of patches TODO: Automate this
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
.int patchTitle2Override_Entry #Address to override
.int _endTitle2Override - _title2Override #Size of code
_title2Override:
	.asciz "title\0" #Replace "title2" with "title "
_endTitle2Override:
