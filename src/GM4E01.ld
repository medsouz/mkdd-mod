/*
	Game addresses
*/
PROVIDE(origEntry = 0x80003154);
PROVIDE(newEntry = 0x803F0000);
PROVIDE(initRegisters = 0x800032B0);
PROVIDE(memcpy = 0x80003540);
/*
	Patch Addresses
*/
PROVIDE(patchTitle2Override_Entry = 0x803CDD6C);

PROVIDE(patchUnrestrictedCharacterCursor_Entry = 0x801639D4);

PROVIDE(patchPreventDriverPassengerMatch_Entry = 0x80162BF4);
PROVIDE(patchPreventDriverPassengerMatch_Code = 0x801639D8);
