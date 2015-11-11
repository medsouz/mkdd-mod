# -----------------------------------------------------------------------
# Adds a comment after every usage of r13 (SDA_BASE) or r2 (SDA2_BASE) to display the address it is referencing
# (c) 2015 Matt "medsouz" Souza
#
from idaapi import *
from idautils import *
import time
# --------------------------------------------------------------------------
class FormatForm(Form):
	def __init__(self):
		self.invert = False
		Form.__init__(self, r"""STARTITEM NULL
BUTTON YES* Start
SDA_BASE Labeler
Addresses
<##SDA_BASE (r13) address:{sdaBase}>
<##SDA2_BASE (r2) address:{sda2Base}>
Written by Matt "medsouz" Souza
""", {
	'sdaBase': Form.NumericInput(tp=Form.FT_ADDR),
	'sda2Base': Form.NumericInput(tp=Form.FT_ADDR)
	})
	def OnFormChange(self, fid):
		return 1
# --------------------------------------------------------------------------
def ida_main():
	# Create form
	global f
	f = FormatForm()
	# Compile (in order to populate the controls)
	f.Compile()
	# Execute the form
	ret = f.Execute()
	# Dispose the form
	f.Free()
	print("r=%d" % ret)
	if ret:
		print("SDA_BASE: " + hex(f.sdaBase.value).rstrip("L"))
		print("SDA2_BASE: " + hex(f.sda2Base.value).rstrip("L"))
		print("--------------------------------------------------------------------------")
		start_time = time.time()
		for ea in range(MinEA(), MaxEA()):
			cmd = GetOpnd(ea, 1);
			if(re.match("-?(0x)?[0-9a-fA-F]+\((r13|r2)\)", cmd)):
				value = int(re.sub("\((r13|r2)\)", "", cmd), 16)
				register = re.sub("-?(0x)?[0-9a-fA-F]+\(", "", cmd).rstrip(")") # I am bad at regex :<
				finalValue = 0
				if(register == "r13"):
					finalValue = value + f.sdaBase.value
				elif(register == "r2"):
					finalValue = value + f.sda2Base.value
				comment = ("GENERATED: Position is " + hex(finalValue).rstrip("L"))
				currComment = Comment(ea)
				if(currComment is not None and currComment != ""):
					print("WARNING! A comment already exists at 0x%x. Appending the generated comment..." % (ea))
					comment = currComment + "\n" + comment
				MakeComm(ea, comment)
		print("DONE!")
		print("--------------------------------------------------------------------------")
		print("Execution took %s seconds" % (time.time() - start_time))
# --------------------------------------------------------------------------
ida_main()
