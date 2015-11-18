Mario Kart Double Dash Modification
===================================
A project to document and eventually provide modifications for Mario Kart Double Dash for the Nintendo Gamecube.

Setup
-----
1. Setup IDA Pro. Install the [DOL loader](http://blog.delroth.net/2012/03/gcwii-dol-plugin-built-for-ida-6-1/) and [GekkoPS plugin](https://github.com/hyperiris/gekkoPS)
2. Copy an NTSC ROM of Mario Kart Double Dash (GM4E01) into the root of the repository and name it mkdd.iso
3. Run ```make GM4E01``` to extract the ISO using [gcmtool](https://github.com/medsouz/GCNToolset/tree/master/GCMTool)
4. Open boot.dol from the newly generated GM4E01 directory in IDA Pro
5. Once autoanalysis is complete run ```scripts/mkdd_dlphn.idc``` to apply the Dolphin generated variable names to your IDA database.
6. Run ```scripts/sda_base_labeler.py``` to label any references to ```_SDA_BASE_``` (r13) and ```_SDA2_BASE_``` (r2). Use the following values to configure the script for Mario Kart Double Dash:
	- ```_SDA_BASE_``` (r13) is ```0x803D1420```
	- ```_SDA2_BASE_``` (r2) is ```0x803D45A0```
7. Run ```mkdd.idc``` to sync your IDA database with the latest names and comments we have documented in the game's code.
8. Poke around in the IDA database and try to document any new and exciting things you find in the game's code.
9. When you're done run ```scripts/nintendump.py```, select ```IDA *.idc```, overwrite ```mkdd.idc``` and submit your changes to this repo.
	- You can also use ```scripts/nintendump.py``` to generate a Dolphin symbol map to display the function names from IDA in Dolphin's debugger. To do this you need to select ```Dolphin *.map``` and save it as ```Dolphin Emulator/Maps/GM4E01.map```

*If you have any issues feel free to contact medsouz for assistance*

Features
--------
#### Mod
* Basic code patching system
* Allows multiple players to select the same characters.
	* Contains a patch to prevent the player from picking the same character twice as this causes a crash

#### Scripts
- nintendump.py
	- Allows you to dump your IDA database into an IDC script to allow you to distribute your work without having to attach the original source code of the program you're working on.
		- This is useful for any IDA project and isn't Gamecube/Wii specific
	- Allows you to generate a Dolphin debug symbol \*.map file to use in Dolphin's debugger
		- This works for both Gamecube and Wii projects
- sda_base_labeler.py
	- Automatically generates comments on most references to ```_SDA_BASE_``` and ```_SDA2_BASE_``` to show the address that they are referencing.
		- This works with any Gamecube project. It may work with Wii projects but I haven't looked into how they handle this.
