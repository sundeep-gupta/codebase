
if ($CmdLine[0] > 0) then 
	if ($CmdLine[1] = "/a") then
		if RegWrite("HKLM\SOFTWARE\McAfee\MSC\Update", "AutoCheckUpd", "REG_BINARY", "4d435247010000000400000004000000dfd046fb000c0a336c00b83eb8712f96a0211b05") then 
			;MsgBox(0, "Information", "Updates are set to Automatic", 2)
		else 
			;MsgBox(0, "Error", "Error updating Registry Key", 2)
		endif
	elseif ($CmdLine[1] = "/p") then
		if RegWrite("HKLM\SOFTWARE\McAfee\MSC\Update", "AutoCheckUpd", "REG_BINARY", "4d435247010000000400000004000000980c952473e8a24b1308aaf68f40ed6b9f221c04") then 
			;MsgBox(0, "Information", "Updates are set to Prompt", 2)
		else
			;MsgBox(0, "Error", "Error updating Registry Key", 2)
		endif
	elseif ($CmdLine[1] = "/n") then
		if RegWrite("HKLM\SOFTWARE\McAfee\MSC\Update", "AutoCheckUpd", "REG_BINARY", "4d4352470100000004000000040000003827d569621fecd143ed118d7a2ea0bea2231907") then 
			;MsgBox(0, "Information", "Updates are set to Notify", 2)
		else
			;MsgBox(0, "Error", "Error updating Registry Key", 2)
		endif
	elseif ($CmdLine[1] = "/d") then
		if RegWrite("HKLM\SOFTWARE\McAfee\MSC\Update", "AutoCheckUpd", "REG_BINARY", "4d435247010000000400000004000000cccb1bc984a215b45623aa7e09cf983ba1241a06") then 
			;MsgBox(0, "Information", "Updates are Disabled", 2)
		else
			;MsgBox(0, "Error", "Error updating Registry Key", 2)
		endif
	else
		;MsgBox(0, "Error", "Unknown command line option", 5)
	endif
else
	;MsgBox(0, "information", "Use one of the following switches to set the update option: /a /p /n /d")
endif
