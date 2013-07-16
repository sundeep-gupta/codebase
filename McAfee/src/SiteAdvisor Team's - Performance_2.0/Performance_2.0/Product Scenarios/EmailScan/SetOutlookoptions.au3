opt("SendKeyDelay",100)
if WinExists("[CLASS:rctrl_renwnd32]") Then
	WinActivate("[CLASS:rctrl_renwnd32]")
	WinWaitActive("[CLASS:rctrl_renwnd32]")
Else
	Exit(0)
EndIf


;select the tools->options menu
Send("!to")

;disable junk email filtering
Send("{ENTER}")
Sleep(1000)
if ControlCommand("Junk E-mail Options","",4160,"IsChecked")=False Then
	ControlCommand("Junk E-mail Options","",4160,"Check")
	Sleep(1000)
EndIf
ControlClick("Junk E-mail Options","",1)


Sleep(1000)
;select the mailsetup tab
Send("+{TAB}")
Send("{RIGHT}")

;select send/Recieve
send("!s")

ControlSetText("Send/Receive Groups","",4096,"1")
if ControlCommand("Send/Receive Groups","",4225,"IsChecked")=False Then
	ControlCommand("Send/Receive Groups","",4225,"Check")
	Sleep(500)
EndIf
Sleep(1000)
;press the close button
Send("!l")

ControlClick("Options","",1)