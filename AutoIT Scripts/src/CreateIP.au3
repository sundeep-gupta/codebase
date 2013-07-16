
For $i = 124 to 240
	WinWait("Advanced TCP/IP Settings")
	Send("!A")
	Winwait("TCP/IP Address")
	Send("10.1.2.")
	Send($i)
	Send("{TAB}")
	Send("255.255.255.0")
	Send("{ENTER}")
	sleep(500)
Next

